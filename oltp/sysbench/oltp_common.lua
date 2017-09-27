-- Copyright (C) 2006-2017 Alexey Kopytov <akopytov@gmail.com>

-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

-- -----------------------------------------------------------------------------
-- Common code for OLTP benchmarks.
-- -----------------------------------------------------------------------------

function init()
   assert(event ~= nil,
          "this script is meant to be included by other OLTP scripts and " ..
             "should not be called directly.")
end

if sysbench.cmdline.command == nil then
   error("Command is required. Supported commands: prepare, prewarm, run, " ..
            "cleanup, help")
end

-- Command line options
sysbench.cmdline.options = {
   table_size =
      {"Number of rows per table", 10000000},
   range_size =
      {"Range size for range SELECT queries", 100},
   tables =
      {"Number of tables", 5},
   point_selects =
     {"Number of point SELECT queries per transaction", 10},
   simple_ranges =
      {"Number of simple range SELECT queries per transaction", 1},
   sum_ranges =
      {"Number of SELECT SUM() queries per transaction", 1},
   order_ranges =
      {"Number of SELECT ORDER BY queries per transaction", 1},
   distinct_ranges =
      {"Number of SELECT DISTINCT queries per transaction", 1},
   index_updates =
      {"Number of UPDATE index queries per transaction", 1},
   non_index_updates =
      {"Number of UPDATE non-index queries per transaction", 1},
   delete_inserts =
      {"Number of DELETE/INSERT combination per transaction", 1},
   range_selects =
      {"Enable/disable all range SELECT queries", true},
   auto_inc =
   {"Use AUTO_INCREMENT column as Primary Key (for MySQL), " ..
       "or its alternatives in other DBMS. When disabled, use " ..
       "client-generated IDs", true},
   skip_trx =
      {"Don't start explicit transactions and execute all queries as " ..
          "in the AUTOCOMMIT mode", false},
   secondary =
      {"Use a secondary index in place of the PRIMARY KEY", false},
   create_secondary =
      {"Create a secondary index in addition to the PRIMARY KEY", true},
   mysql_storage_engine =
      {"Storage engine, if MySQL is used", "innodb"},
   pgsql_variant =
      {"Use this PostgreSQL variant when running with the " ..
          "PostgreSQL driver. The only currently supported " ..
          "variant is 'redshift'. When enabled, " ..
          "create_secondary is automatically disabled, and " ..
          "delete_inserts is set to 0"}
}

-- Prepare the dataset. This command supports parallel execution, i.e. will
-- benefit from executing with --threads > 1 as long as --tables > 1
function cmd_prepare()
   local drv = sysbench.sql.driver()
   local con = drv:connect()

   for i = sysbench.tid % sysbench.opt.threads + 1, sysbench.opt.tables,
   sysbench.opt.threads do
     create_table(drv, con, i)
   end
end

-- Preload the dataset into the server cache. This command supports parallel
-- execution, i.e. will benefit from executing with --threads > 1 as long as
-- --tables > 1
--
-- PS. Currently, this command is only meaningful for MySQL/InnoDB benchmarks
function cmd_prewarm()
   local drv = sysbench.sql.driver()
   local con = drv:connect()

   assert(drv:name() == "mysql", "prewarm is currently MySQL only")

   -- Do not create on disk tables for subsequent queries
   con:query("SET tmp_table_size=2*1024*1024*1024")
   con:query("SET max_heap_table_size=2*1024*1024*1024")

   for i = sysbench.tid % sysbench.opt.threads + 1, sysbench.opt.tables,
   sysbench.opt.threads do
      local t = "sbtest" .. i
      print("Prewarming table " .. t)
      con:query("ANALYZE TABLE sbtest" .. i)
      con:query(string.format(
                   "SELECT AVG(id) FROM " ..
                      "(SELECT * FROM %s FORCE KEY (PRIMARY) " ..
                      "LIMIT %u) t",
                   t, sysbench.opt.table_size))
      con:query(string.format(
                   "SELECT COUNT(*) FROM " ..
                      "(SELECT * FROM %s WHERE k LIKE '%%0%%' LIMIT %u) t",
                   t, sysbench.opt.table_size))
   end
end

-- Implement parallel prepare and prewarm commands
sysbench.cmdline.commands = {
   prepare = {cmd_prepare, sysbench.cmdline.PARALLEL_COMMAND},
   prewarm = {cmd_prewarm, sysbench.cmdline.PARALLEL_COMMAND}
}


-- Generate strings of random digits with 11-digit groups separated by dashes
function get_c_value()
   -- 10 groups, 119 characters
   return sysbench.rand.string("###########-###########-###########-" ..
                               "###########-###########-###########-" ..
                               "###########-###########-###########-" ..
                               "###########")
end

function get_pad_value()
   -- 5 groups, 59 characters
   return sysbench.rand.string("###########-###########-###########-" ..
                               "###########-###########")
end

function create_table(drv, con, table_num)
   local id_index_def, id_def
   local engine_def = ""
   local extra_table_options = ""
   local query

   if sysbench.opt.secondary then
     id_index_def = "KEY xid"
   else
     id_index_def = "PRIMARY KEY"
   end

   if drv:name() == "mysql" or drv:name() == "attachsql" or
      drv:name() == "drizzle"
   then
      if sysbench.opt.auto_inc then
         id_def = "INTEGER NOT NULL AUTO_INCREMENT"
      else
         id_def = "INTEGER NOT NULL"
      end
      engine_def = "/*! ENGINE = " .. sysbench.opt.mysql_storage_engine .. " */"
      extra_table_options = mysql_table_options or ""
   elseif drv:name() == "pgsql"
   then
      if not sysbench.opt.auto_inc then
         id_def = "INTEGER NOT NULL"
      elseif pgsql_variant == 'redshift' then
        id_def = "INTEGER IDENTITY(1,1)"
      else
        id_def = "SERIAL"
      end
   else
      error("Unsupported database driver:" .. drv:name())
   end

   print(string.format("Creating table 'sbtest%d'...", table_num))

   query = string.format([[
CREATE TABLE sbtest%d(
  id %s,
  k INTEGER DEFAULT '0' NOT NULL,
  c CHAR(120) DEFAULT '' NOT NULL,
  pad CHAR(60) DEFAULT '' NOT NULL,
  %s (id)
) %s %s]],
      table_num, id_def, id_index_def, engine_def, extra_table_options)

   con:query(query)

   print(string.format("Inserting %d records into 'sbtest%d'",
                       sysbench.opt.table_size, table_num))

   if sysbench.opt.auto_inc then
      query = "INSERT INTO sbtest" .. table_num .. "(k, c, pad) VALUES"
   else
      query = "INSERT INTO sbtest" .. table_num .. "(id, k, c, pad) VALUES"
   end

   con:bulk_insert_init(query)

   local c_val
   local pad_val

   for i = 1, sysbench.opt.table_size do

      c_val = get_c_value()
      pad_val = get_pad_value()

      if (sysbench.opt.auto_inc) then
         query = string.format("(%d, '%s', '%s')",
                               sb_rand(1, sysbench.opt.table_size), c_val,
                               pad_val)
      else
         query = string.format("(%d, %d, '%s', '%s')",
                               i, sb_rand(1, sysbench.opt.table_size), c_val,
                               pad_val)
      end

      con:bulk_insert_next(query)
   end

   con:bulk_insert_done()

   if sysbench.opt.create_secondary then
      print(string.format("Creating a secondary index on 'sbtest%d'...",
                          table_num))
      con:query(string.format("CREATE INDEX k_%d ON sbtest%d(k)",
                              table_num, table_num))
   end
end

local t = sysbench.sql.type
local stmt_defs = {
   point_selects = {
      "SELECT c FROM sbtest%u WHERE id=?",
      t.INT},
   simple_ranges = {
      "SELECT c FROM sbtest%u WHERE id BETWEEN ? AND ?",
      t.INT, t.INT},
   sum_ranges = {
      "SELECT SUM(k) FROM sbtest%u WHERE id BETWEEN ? AND ?",
       t.INT, t.INT},
   order_ranges = {
      "SELECT c FROM sbtest%u WHERE id BETWEEN ? AND ? ORDER BY c",
       t.INT, t.INT},
   distinct_ranges = {
      "SELECT DISTINCT c FROM sbtest%u WHERE id BETWEEN ? AND ? ORDER BY c",
      t.INT, t.INT},
   index_updates = {
      "UPDATE sbtest%u SET k=k WHERE id=?",
      t.INT},
   non_index_updates = {
      "UPDATE sbtest%u SET c=? WHERE id=?",
      {t.CHAR, 120}, t.INT},
   deletes = {
      "DELETE FROM sbtest%u WHERE id=?",
      t.INT},
   inserts = {
      "INSERT INTO sbtest%u (id, k, c, pad) VALUES (?, ?, ?, ?)",
      t.INT, t.INT, {t.CHAR, 120}, {t.CHAR, 60}},
}

function prepare_begin()
--   stmt.begin = con:prepare("BEGIN")
     con:query("START TRANSACTION")
end

function prepare_commit()
--   stmt.commit = con:prepare("COMMIT")
     con:query("COMMIT")
end

function prepare_for_each_table(key)
   for t = 1, sysbench.opt.tables do
      stmt[t][key] = con:prepare(string.format(stmt_defs[key][1], t))

      local nparam = #stmt_defs[key] - 1

      if nparam > 0 then
         param[t][key] = {}
      end

      for p = 1, nparam do
         local btype = stmt_defs[key][p+1]
         local len

         if type(btype) == "table" then
            len = btype[2]
            btype = btype[1]
         end
         if btype == sysbench.sql.type.VARCHAR or
            btype == sysbench.sql.type.CHAR then
               param[t][key][p] = stmt[t][key]:bind_create(btype, len)
         else
            param[t][key][p] = stmt[t][key]:bind_create(btype)
         end
      end

      if nparam > 0 then
         stmt[t][key]:bind_param(unpack(param[t][key]))
      end
   end
end

function prepare_point_selects()
   prepare_for_each_table("point_selects")
end

function prepare_simple_ranges()
   prepare_for_each_table("simple_ranges")
end

function prepare_sum_ranges()
   prepare_for_each_table("sum_ranges")
end

function prepare_order_ranges()
   prepare_for_each_table("order_ranges")
end

function prepare_distinct_ranges()
   prepare_for_each_table("distinct_ranges")
end

function prepare_index_updates()
   prepare_for_each_table("index_updates")
end

function prepare_non_index_updates()
   prepare_for_each_table("non_index_updates")
end

function prepare_delete_inserts()
   prepare_for_each_table("deletes")
   prepare_for_each_table("inserts")
end

function thread_init()
   drv = sysbench.sql.driver()
   con = drv:connect()

   -- Create global nested tables for prepared statements and their
   -- parameters. We need a statement and a parameter set for each combination
   -- of connection/table/query
   stmt = {}
   param = {}

   for t = 1, sysbench.opt.tables do
      stmt[t] = {}
      param[t] = {}
   end

   -- This function is a 'callback' defined by individual benchmark scripts
   prepare_statements()
end

function thread_done()
   -- Close prepared statements
   for t = 1, sysbench.opt.tables do
      for k, s in pairs(stmt[t]) do
         stmt[t][k]:close()
      end
   end
   if (stmt.begin ~= nil) then
      stmt.begin:close()
   end
   if (stmt.commit ~= nil) then
      stmt.commit:close()
   end
   con:disconnect()
end

function cleanup()
   local drv = sysbench.sql.driver()
   local con = drv:connect()

   for i = 1, sysbench.opt.tables do
      print(string.format("Dropping table 'sbtest%d'...", i))
      con:query("DROP TABLE IF EXISTS sbtest" .. i )
   end
end

local function get_table_num()
   return sysbench.rand.uniform(1, sysbench.opt.tables)
end

local function get_id()
   return sysbench.rand.default(1, sysbench.opt.table_size)
end

function begin()
   con:query("START TRANSACTION")
--   stmt.begin:execute()
end

function commit()
   con:query("COMMIT")

--   stmt.commit:execute()
end

function execute_point_selects()
   local tnum = get_table_num()
   local i
   for i = 1, sysbench.opt.point_selects do
       local table_name = "sbtest" .. sysbench.rand.uniform(1, sysbench.opt.tables)	
       local id=get_id()
	con:query(string.format("select c from %s where id=%d",
                              table_name,id))
      --param[tnum].point_selects[1]:set(get_id())
     -- stmt[tnum].point_selects:execute()
   end
end

local function execute_range(key)
    for i = 1, sysbench.opt[key] do
      local id = get_id()
      local id_last = id + sysbench.opt.range_size - 1
    --  print(id)
     -- print(id_last)
      local table_name = "sbtest" .. sysbench.rand.uniform(1, sysbench.opt.tables)
      --print(key) 
      if key=="simple_ranges" then
	 con:query(string.format("select c from %s where id =%d",
                              table_name,id))
      end
      if key=="sum_ranges" then
         con:query(string.format("select sum(k) from %s where id between %d and %d",
                              table_name,id,id_last))
     end
      if key=="order_ranges" then
         con:query(string.format("select c from %s where id between %d and %d order by c",
                              table_name,id,id_last))
      end
      if key=="ditinct_ranges" then
         con:query(string.format("select distinct c from %s where id between %d and %d order by c",
                              table_name,id,id_last))
end

  
--      param[tnum][key][1]:set(id)
--    param[tnum][key][2]:set(id + sysbench.opt.range_size - 1)

--      stmt[tnum][key]:execute()
    end
end

function execute_simple_ranges()
   execute_range("simple_ranges")
end

function execute_sum_ranges()
   execute_range("sum_ranges")
end

function execute_order_ranges()
   execute_range("order_ranges")
end

function execute_distinct_ranges()
   execute_range("distinct_ranges")
end

function execute_index_updates()
   local tnum = get_table_num()

   for i = 1, sysbench.opt.index_updates do
      param[tnum].index_updates[1]:set(get_id())

      stmt[tnum].index_updates:execute()
   end
end

function execute_non_index_updates()
   local tnum = get_table_num()

   for i = 1, sysbench.opt.non_index_updates do
      param[tnum].non_index_updates[1]:set(get_c_value())
      param[tnum].non_index_updates[2]:set(get_id())

      stmt[tnum].non_index_updates:execute()
   end
end

function execute_delete_inserts()
   local tnum = get_table_num()

   for i = 1, sysbench.opt.delete_inserts do
      local id = get_id()
      local k = get_id()

      param[tnum].deletes[1]:set(id)

      param[tnum].inserts[1]:set(id)
      param[tnum].inserts[2]:set(k)
      param[tnum].inserts[3]:set(get_c_value())
      param[tnum].inserts[4]:set(get_pad_value())

      stmt[tnum].deletes:execute()
      stmt[tnum].inserts:execute()
   end
end
