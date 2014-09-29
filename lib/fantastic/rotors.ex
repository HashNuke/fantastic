defmodule Fantastic.Rotors do
  import Rotor.BasicRotors
  import CoffeeRotor


  def start(options) do
    options = determine_options(options)
    File.mkdir_p!(options[:output_path])


    rotor_options = %{manual: true}
    Rotor.watch :coffeescripts, options.javascript_paths, fn(_changed_files, all_files)->
      read_files(all_files)
      |> coffee
      |> concat
      |> digested_output_to(options[:output_path], "js")
    end, rotor_options


    Rotor.watch :stylesheets, options.stylesheet_paths, fn(_changed_files, all_files)->
      read_files(all_files)
      |> coffee
      |> concat
      |> digested_output_to(options[:output_path], "css")
    end, rotor_options


    #TODO should output the same file name with digest
    # Rotor.watch :other_paths, other_asset_paths(options.base_path), fn(_changed_files, all_files)->
    #   read_files(all_files)
    #   |> coffee
    #   |> concat
    #   |> digested_output_to(options[:output_path])
    # end, rotor_options
  end


  defp other_asset_paths(base_path) do
    File.ls!(".")
    |> Enum.filter(&File.dir?/1)
    |> Enum.map( fn(dir)-> "#{base_path}/#{dir}/*" end )
  end


  defp determine_options(options) do
    default_options = %{
      base_path: "priv/assets",
      use_digest: true,
      output_path: "priv/static/assets"
    }

    merge_options(default_options, options)
  end


  defp merge_options(options1, options2) do
    options = Map.merge(options1, options2)

    Map.put(options, :javascript_paths, ["#{options.base_path}/javascripts"])
    |> Map.put(:stylesheet_paths, ["#{options.base_path}/stylesheets"])
  end


  defp digested_output_to(contents, output_dir, extension) do
    digest = calculate_digest(contents)
    "#{output_dir}/app-#{digest}.#{extension}"
  end


  defp calculate_digest(contents) do
    :crypto.sha_mac("rotor", contents) |> Base.encode16 |> String.downcase
  end

end
