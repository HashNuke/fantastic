defmodule Fantastic.Rotors do
  import Rotor.BasicRotors
  import CoffeeRotor

  def start(options) do
    options = determine_options(options)
    File.mkdir_p!(options[:output_path])


    rotor_options = %{manual: true}
    Rotor.watch :coffeescripts, , fn(_changed_files, all_files)->
      read_files(all_files)
      |> coffee
      |> concat
      |> digested_output_to(options[:output_path])
    end, rotor_options


    Rotor.watch :stylesheets, ["priv/assets/stylesheets/*.scss"], fn(_changed_files, all_files)->
      read_files(all_files)
      |> coffee
      |> concat
      |> digested_output_to(options[:output_path])
    end, rotor_options

    # TODO
    # Use the following to list dirs in asset path
    # Path.Wildcard.list_dir options[]

    Rotor.watch :other_paths, ["priv/assets/stylesheets/*.scss"], fn(_changed_files, all_files)->
      read_files(all_files)
      |> coffee
      |> concat
      |> digested_output_to(asset_output_path)
    end, rotor_options
  end


  defp determine_options(options) do
    #TODO base path to replace priv/static/assets

    default_options = %{
      javascript_paths: ["priv/assets/javascripts/*"],
      stylesheet_paths: ["priv/assets/stylesheets/*"],
      use_digest: true,
      output_path: "priv/static/assets"
    }

    merge_options(default_options, options)
  end


  defp merge_options(options1, options2) do
    #TODO
  end


  defp digested_output_to(contents, asset_type, dir_path) do
    digest = calculate_digest(contents)
    "#{dir_path}/app-#{digest}.js"
  end


  defp calculate_digest(contents) do
    :crypto.sha_mac("rotor", contents) |> Base.encode16 |> String.downcase
  end

end
