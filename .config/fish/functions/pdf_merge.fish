function pdf_merge --description "Merge multiple PDF files into a single PDF."
    argparse 'h/help' -- $argv
    or return

    if set -q _flag_help
        echo "Usage: pdfmerge <output.pdf> <input1.pdf> [input2.pdf ...]"
        echo ""
        echo "Merges one or more input PDF files into a single output PDF file."
        echo ""
        echo "Arguments:"
        echo "  output.pdf   The name of the new PDF file to create."
        echo "  input.pdf    One or more input PDF files to merge."
        echo ""
        echo "Example:"
        echo "  pdfmerge all_docs.pdf chapter1.pdf chapter2.pdf appendix.pdf"
        return 0
    end

    if test (count $argv) -lt 2
        echo "Error: Missing arguments." >&2
        pdfmerge --help
        return 1
    end

    set -l output_file (echo $argv[1])
    set -l input_files (echo $argv[2..-1])

    for file in $input_files
        if not test -f "$file"
            echo "Error: Input file '$file' not found." >&2
            return 1
        end
    end

    echo "Merging files into '$output_file'..."
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$output_file" $input_files

    if test $status -eq 0
        echo "PDFs merged successfully!"
    else
        echo "Error: PDF merging failed." >&2
        return 1
    end
end
