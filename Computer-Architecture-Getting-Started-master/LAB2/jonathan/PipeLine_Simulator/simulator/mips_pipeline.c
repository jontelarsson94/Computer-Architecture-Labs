#include "pipeline.h"
#include "utils.h"
#include <stdio.h>
#include <stdlib.h>

static void Usage(const char* cmd)
{
	fprintf(stderr, "Usage: %s <name of MIPS assembly file>\n", cmd);
	EXIT_APPL(EXIT_FAILURE);
}

int main(int cmd_line_length, const char* cmd_line[])
{
	FILE* mips_file;

	if (cmd_line_length != 2)
		Usage(cmd_line[0]);

	// Open and parse the MIPS file
	mips_file = fopen(cmd_line[1], "r");
	if (mips_file == 0)
	{
		fprintf(stderr, "Could not open file %s for reading\n", cmd_line[1]);
		EXIT_APPL(EXIT_FAILURE);
	}
	InitPipeline(mips_file);
	fclose(mips_file);

	SetTracing(1);
	RunProgram();
	
	printf("Number of cycles: %d\n", GetElapsedCycles());
	printf("Number of retired instructions: %d\n", GetNrOfRetiredInstructions());
	printf("Average CPI: %f\n", GetCPI());
	
	EXIT_APPL(EXIT_SUCCESS);
}
