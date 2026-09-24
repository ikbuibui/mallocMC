# CPM Package Lock
# This file should be committed to version control

# alpaka
CPMDeclarePackage(alpaka
  NAME alpaka
  GIT_TAG dev
  GITHUB_REPOSITORY alpaka-group/alpaka3
  OPTIONS
    "alpaka_CXX_STANDARD 20;alpaka_INSTALL ON"
  # It is recommended to let CPM cache dependencies in order to reduce redundant downloads.
  # The dev branch is a moving reference; disable CPM caching so updates to its head are fetched.
  NO_CACHE TRUE
)
# cmake-scripts
CPMDeclarePackage(cmake-scripts
  GIT_TAG 24.04
  GITHUB_REPOSITORY StableCoder/cmake-scripts
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
)
# Catch2
CPMDeclarePackage(Catch2
  VERSION 3.7.0
  GITHUB_REPOSITORY catchorg/Catch2
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
)
# Gallatin
CPMDeclarePackage(Gallatin
  # There's no release available yet.
  GIT_TAG ac0cb8e380ffcb74156bafb8805fb60412817c5f
  # Use our own fork for some patches
  GITHUB_REPOSITORY chillenzer/Gallatin
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
)
