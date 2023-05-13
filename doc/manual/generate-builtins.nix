let
  inherit (builtins) concatStringsSep attrValues mapAttrs;
  inherit (import ./utils.nix) optionalString;
in

builtinsInfo:
let
  showBuiltin = name: { doc, args, arity, experimental-feature }:
    let
      xpNotice = optionalString (experimental-feature != null) ''


        This function is only available if you enable the
        [experimental](@docroot@/contributing/experimental-features.md) feature
        [${experimental-feature}](@docroot@/contributing/experimental-features.md#xp-feature-${experimental-feature}.
      '';
    in
    ''
      <dt id="builtins-${name}">
        <a href="#builtins-${name}"><code>${name} ${listArgs args}</code></a>
      </dt>
      <dd>

        ${doc + xpNotice}

      </dd>
    '';
  listArgs = args: concatStringsSep " " (map (s: "<var>${s}</var>") args);
in
concatStringsSep "\n" (attrValues (mapAttrs showBuiltin builtinsInfo))
