with import <nixpkgs> {
    crossSystem = {
        config = "i386-elf";
    };
};

mkShell {
    buildInputs = [ ];
}
