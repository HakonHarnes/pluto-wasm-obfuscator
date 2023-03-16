processors=$1
if [ -z $processors ]; then
    processors=$(($(nproc) / 2))
fi

mkdir -p build
cd build || exit 

cmake -G "Ninja" -DLLVM_ENABLE_PROJECTS="lld" \
-DLLVM_TARGETS_TO_BUILD="host;WebAssembly" \
-DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
-DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF \
-DBUILD_SHARED_LIBS=On -DCMAKE_INSTALL_PREFIX="../install" ../llvm

echo "-- Building on $(uname)"
echo "-- Building with $processors CPU cores"

ninja -j$processors
ninja install
