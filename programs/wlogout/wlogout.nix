{ pkgs, ... }:

{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "  Logout  ";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = " Reboot ";
        keybind = "u";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
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
        color: #FFFFFF;
        font-family: "monospace";
        font-size: 20px;
	      background-color: #1A1B26;

        border-radius: 10px;
	      border-style: none;
	      border-width: 0px;
	
        background-repeat: no-repeat;
	      background-position: center;
	      background-size: 25%;
      }

      button:focus, button:active, button:hover {
	      background-color: #468284;
	      outline-style: none;
      }

      #lock, #logout, #suspend, #hibernate, #shutdown, #reboot {
        opacity: 0.9;
      }
           
      #logout {
      	margin: 50px;
      	border-radius: 20px;
      	background-image: image(url("${./icons/logout.png}"));
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
