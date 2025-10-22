{ vars, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [
      "llama3.2:3b"
      "gemma3:1b"
      "gemma3:4b"
      "nomic-embed-text"
    ];
    # acceleration = "";
  };
  services.open-webui = {
    enable = true;
    port = 4923;
  };
}
