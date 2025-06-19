function pdf_split --description "Split a PDF file into a new file containing a specified page range."
    argparse 'h/help' -- $argv
    or return

    if set -q _flag_help
        echo "Usage: pdfsplit <input.pdf> <first_page> <last_page> <output.pdf>"
        echo ""
        echo "Splits a PDF file, extracting pages from 'first_page' to 'last_page' (inclusive)"
        echo "and saving them to 'output.pdf'."
        echo ""
        echo "Arguments:"
        echo "  input.pdf    The path to the input PDF file."
        echo "  first_page   The number of the first page to extract."
        echo "  last_page    The number of the last page to extract."
        echo "  output.pdf   The path for the output PDF file."
        echo ""
        echo "Example:"
        echo "  pdfsplit my_document.pdf 5 10 extracted_pages.pdf"
        return 0
    end

    if test (count $argv) -lt 4
        echo "Error: Missing arguments." >&2
        pdfsplit --help
        return 1
    end

    set -l input_pdf $argv[1]
    set -l first_page $argv[2]
    set -l last_page $argv[3]
    set -l output_pdf $argv[4]

    if not test -f "$input_pdf"
        echo "Error: Input file '$input_pdf' not found." >&2
        return 1
    end

    echo "Splitting '$input_pdf' from page $first_page to $last_page into '$output_pdf'..."

    gs -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output_pdf" -dFirstPage="$first_page" -dLastPage="$last_page" -sDEVICE=pdfwrite "$input_pdf"

    if test $status -eq 0
        echo "PDF split successfully!"
    else
        echo "Error: PDF splitting failed." >&2
        return 1
    end
end

