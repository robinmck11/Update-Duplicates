require 'csv';

if !ARGV[0] || !ARGV[1]
  raise "Error:\n\tIncorrect number of arguments provided
        \nUsage:\n\truby make-unique.rb <file> <column_name>"
end

file_name = ARGV[0]
column_name = ARGV[1];
column_index = 0;

csv = CSV.read(file_name);

# Throw an error if the column isn't found
# Else set the column index
csv[0].each_with_index do | column, i |
  if !csv[0].include? column_name
    raise "Error:\n\tcolumn name not found
          \nUsage:\n\truby make-unique.rb <file> <column_name>"
  else
    column_index = i;
  end
end

csv.each_with_index do | line, i |
  # Don't process column names
  if i == 0
    next;
  end

  line.each_with_index do | line_item, j |

    # Skip the columns that don't concern us
    if j != column_index
      next;
    end

    count_processed = 1;
    processed_duplicates = false;

    # if next item is the same as current item
    # update the next item keep going until we set the flag
    # and update the index
    while !processed_duplicates
      if i + count_processed == csv.length
        break;
      end

      next_line_item = csv[i+count_processed][column_index];

      if line_item == next_line_item
        csv[i+count_processed][column_index] = csv[i+count_processed][column_index] + '-' + count_processed.to_s;
        count_processed = count_processed + 1;
      else
        processed_duplicates = true;
        j = j + count_processed;
      end
    end
  end
end

# Write to a new file
CSV.open("output.csv", "wb") do | file |
  csv.map { | line | file << line }
end
