/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_tanukisoftware_wrapper_WrapperProcessConfig */

#ifndef _Included_org_tanukisoftware_wrapper_WrapperProcessConfig
#define _Included_org_tanukisoftware_wrapper_WrapperProcessConfig
#ifdef __cplusplus
extern "C" {
#endif
#undef org_tanukisoftware_wrapper_WrapperProcessConfig_POSIX_SPAWN
#define org_tanukisoftware_wrapper_WrapperProcessConfig_POSIX_SPAWN 1L
#undef org_tanukisoftware_wrapper_WrapperProcessConfig_FORK_EXEC
#define org_tanukisoftware_wrapper_WrapperProcessConfig_FORK_EXEC 2L
#undef org_tanukisoftware_wrapper_WrapperProcessConfig_VFORK_EXEC
#define org_tanukisoftware_wrapper_WrapperProcessConfig_VFORK_EXEC 3L
#undef org_tanukisoftware_wrapper_WrapperProcessConfig_DYNAMIC
#define org_tanukisoftware_wrapper_WrapperProcessConfig_DYNAMIC 4L
/*
 * Class:     org_tanukisoftware_wrapper_WrapperProcessConfig
 * Method:    nativeGetEnv
 * Signature: ()[Ljava/lang/String;
 */
JNIEXPORT jobjectArray JNICALL Java_org_tanukisoftware_wrapper_WrapperProcessConfig_nativeGetEnv
  (JNIEnv *, jobject);

/*
 * Class:     org_tanukisoftware_wrapper_WrapperProcessConfig
 * Method:    isSupportedNative
 * Signature: (I)Z
 */
JNIEXPORT jboolean JNICALL Java_org_tanukisoftware_wrapper_WrapperProcessConfig_isSupportedNative
  (JNIEnv *, jclass, jint);

#ifdef __cplusplus
}
#endif
#endif
