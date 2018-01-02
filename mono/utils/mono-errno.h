/**
 * \file
 * Access the native error code
 *
 * Author:
 *   Alexander Kyte (alkyte@microsoft.com)
 *
 * (C) 2018 Microsoft, Inc.
 *
 */

#ifndef __MONO_ERRNO_H__
#define __MONO_ERRNO_H__

// Enough indirection to do something else here, or log

#if defined(__NuttX__) && !defined(__DIRECT_ERRNO_ACCESS)
#define SET_ERRNO(errno_val) do { \
	set_errno(errno_val); \
} while (0);
#else
#define SET_ERRNO(errno_val) do { \
	errno = errno_val; \
} while (0);
#endif

#endif
