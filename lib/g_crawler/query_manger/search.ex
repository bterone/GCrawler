defmodule GCrawler.QueryManager.Search do
  def queue_search(csv_file_path, report_id) when is_binary(csv_file_path) do
    # TODO: Add is_csv(csv_file_path)
    # Should be guard clause to check for csv format
    # Also check if csv contents follow a sensible standard
    NimbleCSV.define(MyParser, separator: "\t", escape: "\"")

    csv_file_path
    |> File.stream!()
    |> MyParser.parse_stream()
    |> Stream.chunk_every(10)
    |> Stream.map(&List.flatten/1)
    |> Task.async_stream(&request_search(&1, report_id))
    |> Stream.run()
  end

  def request_search(query_list, report_id) when is_list(query_list) do
    IO.puts("Requesting searches for these keywords")
    IO.inspect(query_list)

    query_map =
      query_list
      |> Enum.map(&%{search_term: &1})

    Enum.each(query_map, fn query ->
      case GCrawler.Search.create_query_result(query) do
        {:ok, query_result} ->
          # TODO: Create query result report entry
          IO.puts("Successfully created record for:")
          IO.inspect(query)

          GCrawler.Search.create_search_queue(%{
            report_id: report_id,
            query_result_id: query_result.id
          })

        {:error, %Ecto.Changeset{} = changeset} ->
          # TODO: Raise error
          IO.puts("Error creating:")
          IO.inspect(changeset)
      end
    end)

    # Insert into query table
    # Searchable service
  end
end
