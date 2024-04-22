import sys

def add_spaces(input_file, output_file):
    with open(input_file, 'r') as f_in:
        with open(output_file, 'w') as f_out:
            for line in f_in:
                modified_line = ' '.join(line[i:i+2] for i in range(0, len(line), 2))
                f_out.write(modified_line)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py input_file output_file")
    else:
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        add_spaces(input_file, output_file)
