{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      rust-lang.rust-analyzer
    ];
    enableUpdateCheck = false;
    keybindings = [
      {
          key = "alt+shift+[";
          command = "editor.fold";
          when = "editorTextFocus && foldingEnabled";
      }
      {
          key = "alt+shift+]";
          command = "editor.unfold";
          when = "editorTextFocus && foldingEnabled";        
      } 
      {
          key = "alt+n";
          command = "explorer.newFile";        
      }
      {
          key = "alt+shift+n";
          command = "explorer.newFolder";
      }
      {
          key = "alt+j";
          command = "workbench.action.previousEditor";
      }
      {
          key = "ctrl+pageup";
          command = "-workbench.action.previousEditor";
      }
      {
          key = "alt+k";
          command = "workbench.action.nextEditor";
      }
      {
          key = "ctrl+pagedown";
          command = "-workbench.action.nextEditor";
      }
      {
          key = "shift+alt+pagedown";
          command = "editor.action.copyLinesDownAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+shift+alt+down";
          command = "-editor.action.copyLinesDownAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "shift+alt+pageup";
          command = "editor.action.copyLinesUpAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "ctrl+shift+alt+up";
          command = "-editor.action.copyLinesUpAction";
          when = "editorTextFocus && !editorReadonly";
      }
      {
          key = "shift+alt+e";
          command = "workbench.view.explorer";
          when = "viewContainer.workbench.view.explorer.enabled";
      }
      {
          key = "ctrl+shift+e";
          command = "-workbench.view.explorer";
          when = "viewContainer.workbench.view.explorer.enabled";
      }
      {
          key = "alt+e";
          command = "workbench.explorer.fileView.focus";
      }
      {
          key = "ctrl+k e";
          command = "workbench.files.action.focusOpenEditorsView";
          when = "workbench.explorer.openEditorsView.active";
      }
      {
          key = "ctrl+k e";
          command = "-workbench.files.action.focusOpenEditorsView";
          when = "workbench.explorer.openEditorsView.active";
      }
      {
          key = "alt+o";
          command = "workbench.action.focusActiveEditorGroup";
      }
      {
          key = "shift+alt+k";
          command = "editor.action.insertCursorAbove";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+up";
          command = "-editor.action.insertCursorAbove";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+j";
          command = "editor.action.insertCursorBelow";
          when = "editorTextFocus";
      }
      {
          key = "shift+alt+down";
          command = "-editor.action.insertCursorBelow";
          when = "editorTextFocus";
      }
      {
          key = "alt+g";
          command = "workbench.view.scm";
          when = "workbench.scm.active";
      }
      {
          key = "ctrl+shift+g";
          command = "-workbench.view.scm";
          when = "workbench.scm.active";
      }
    ];

    userSettings = {
      "window.zoomLevel" = 1;
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.iconTheme" = "Monokai Pro Icons";
      "workbench.colorTheme" = "Dracula";
      "window.menuBarVisibility" = "toggle";
      "workbench.activityBar.location" = "hidden";
      "explorer.confirmDelete" = false;
      "editor.fontFamily" = "'Hack Nerd Font'";
      "catppuccin.accentColor" = "blue";
    };
  };
}
