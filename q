commit 3dcb847d7fc04efc77c5d853efd4165d01d4a10f
Author: RossC <stard0g101@hotmail.com>
Date:   Mon Sep 20 16:19:16 2010 +0100

    Added LICENSE and setup

diff --git a/LICENSE.txt b/LICENSE.txt
new file mode 100644
index 0000000..ec13610
--- /dev/null
+++ b/LICENSE.txt
@@ -0,0 +1,25 @@
+Copyright 2010 Ross Crawford. All rights reserved.
+
+Redistribution and use in source and binary forms, with or without modification, are
+permitted provided that the following conditions are met:
+
+   1. Redistributions of source code must retain the above copyright notice, this list of
+      conditions and the following disclaimer.
+
+   2. Redistributions in binary form must reproduce the above copyright notice, this list
+      of conditions and the following disclaimer in the documentation and/or other materials
+      provided with the distribution.
+
+THIS SOFTWARE IS PROVIDED BY Ross Crawford ``AS IS'' AND ANY EXPRESS OR IMPLIED
+WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
+FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Ross Crawford OR
+CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+The views and conclusions contained in the software and documentation are those of the
+authors and should not be interpreted as representing official policies, either expressed
+or implied, of Ross Crawford.
diff --git a/setup.py b/setup.py
new file mode 100644
index 0000000..42ba1cc
--- /dev/null
+++ b/setup.py
@@ -0,0 +1,120 @@
+import os
+import sys
+from fnmatch import fnmatchcase
+from distutils.util import convert_path
+from setuptools import setup, find_packages
+
+VERSION = __import__('dictionary').__version__
+
+def read(*path):
+    return open(os.path.join(os.path.abspath(os.path.dirname(__file__)), *path)).read()
+
+# Provided as an attribute, so you can append to these instead
+# of replicating them:
+standard_exclude = ('*.py', '*.pyc', '*~', '.*', '*.bak')
+standard_exclude_directories = ('.*', 'CVS', '_darcs', './build',
+                                './dist', 'EGG-INFO', '*.egg-info')
+
+# Copied from paste/util/finddata.py
+def find_package_data(where='.', package='', exclude=standard_exclude,
+        exclude_directories=standard_exclude_directories,
+        only_in_packages=True, show_ignored=False):
+    """
+    Return a dictionary suitable for use in ``package_data``
+    in a distutils ``setup.py`` file.
+
+    The dictionary looks like::
+
+        {'package': [files]}
+
+    Where ``files`` is a list of all the files in that package that
+    don't match anything in ``exclude``.
+
+    If ``only_in_packages`` is true, then top-level directories that
+    are not packages won't be included (but directories under packages
+    will).
+
+    Directories matching any pattern in ``exclude_directories`` will
+    be ignored; by default directories with leading ``.``, ``CVS``,
+    and ``_darcs`` will be ignored.
+
+    If ``show_ignored`` is true, then all the files that aren't
+    included in package data are shown on stderr (for debugging
+    purposes).
+
+    Note patterns use wildcards, or can be exact paths (including
+    leading ``./``), and all searching is case-insensitive.
+    """
+
+    out = {}
+    stack = [(convert_path(where), '', package, only_in_packages)]
+    while stack:
+        where, prefix, package, only_in_packages = stack.pop(0)
+        for name in os.listdir(where):
+            fn = os.path.join(where, name)
+            if os.path.isdir(fn):
+                bad_name = False
+                for pattern in exclude_directories:
+                    if (fnmatchcase(name, pattern)
+                        or fn.lower() == pattern.lower()):
+                        bad_name = True
+                        if show_ignored:
+                            print >> sys.stderr, (
+                                "Directory %s ignored by pattern %s"
+                                % (fn, pattern))
+                        break
+                if bad_name:
+                    continue
+                if (os.path.isfile(os.path.join(fn, '__init__.py'))
+                    and not prefix):
+                    if not package:
+                        new_package = name
+                    else:
+                        new_package = package + '.' + name
+                    stack.append((fn, '', new_package, False))
+                else:
+                    stack.append((fn, prefix + name + '/', package, only_in_packages))
+            elif package or not only_in_packages:
+                # is a file
+                bad_name = False
+                for pattern in exclude:
+                    if (fnmatchcase(name, pattern)
+                        or fn.lower() == pattern.lower()):
+                        bad_name = True
+                        if show_ignored:
+                            print >> sys.stderr, (
+                                "File %s ignored by pattern %s"
+                                % (fn, pattern))
+                        break
+                if bad_name:
+                    continue
+                out.setdefault(package, []).append(prefix+name)
+    return out
+
+excluded_directories = standard_exclude_directories + ('./requirements', './scripts')
+package_data = find_package_data(exclude_directories=excluded_directories)
+
+setup(
+    name='Django Dictionary App',
+    version=VERSION,
+    description='The Django Dictionary App is an open-source re-usable app for the Django Web Framework',
+    author='Ross Crawford',
+    author_email='sendrossemail@gmail.com',
+    maintainer='Ross Crawford',
+    maintainer_email='sendrossemail@gmail.com',
+    url='http://github.com/stard0g101/Django-Dictionary-App/',
+    packages=find_packages(),
+    package_data=package_data,
+    zip_safe=False,
+    classifiers=[
+        'Development Status :: 1 - Beta',
+        'Environment :: Web Environment',
+        'Intended Audience :: Developers',
+        'License :: OSI Approved :: FreeBSD License',
+        'Operating System :: OS Independent',
+        'Framework :: Django',
+        'Programming Language :: Python',
+        'Programming Language :: Python :: 2.6',
+    ],
+)
+
