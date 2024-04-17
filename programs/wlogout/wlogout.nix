{ pkgs, ... }:

{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "sleep 1 && exec swaylock -fF";
        text = "  Lock  ";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "sleep 1 && systemctl reboot";
        text = " Reboot ";
        keybind = "u";
      }
      {
        label = "shutdown";
        action = "sleep 1 && systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
    ];

    style = ''
      * {
	      background-image: none;
        transition: 20ms;
        box-shadow: none;
      }

      window {
	      background-color: rgba(0, 0, 0, 0);
      }

      button {
        color: #cad3f5;
        font-family: "monospace";
        font-size: 20px;
	      background-color: #24273a;

        border-radius: 10px;
	      border-style: none;
	      border-width: 0px;
	
        background-repeat: no-repeat;
	      background-position: center;
	      background-size: 25%;

        border: 2px solid #8aadf4;
      }

      button:focus, button:active, button:hover {
	      background-color: #5b6078;
      }

      #lock, #logout, #suspend, #hibernate, #shutdown, #reboot {
        opacity: 0.9;
      }
           
      #lock {
      	margin: 50px;
      	border-radius: 20px;
      	background-image: image(url("${./icons/lock.png}"));
      }
      
      #reboot {
      	margin: 50px;
      	border-radius: 20px;
      	background-image: image(url("${./icons/reboot.png}"));
      }

      #shutdown {
      	margin: 50px;
      	border-radius: 20px;
      	background-image: image(url("${./icons/shutdown.png}"));
      }
    '';
  };
}
