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

#define SET_ERRNO(errno_val) do { \
	errno = errno_val; \
} while (0);

#endif
