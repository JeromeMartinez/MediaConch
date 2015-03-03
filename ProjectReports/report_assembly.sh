#!/bin/bash

# unassigned reports
# Timeline.md

reportsuffix="MediaAreaConch"
phase1_report_basename="${reportsuffix}_DesignReport"
conformance_check_appendix_basename="${reportsuffix}_Appendix_ConformanceCheckRegistry"
standardization_appendix_basename="${reportsuffix}_Appendix_Standardization"
pwd=$(pwd)
cd $(dirname "${0}")
cd ..
echo "" > "tmp_${phase1_report_basename}.md"
for report in \
    DesignIntroduction.md \
    DesignNarrative.md \
    ArchitectureIntroduction.md \
    GlobalArchitecture.md \
    CheckerArchitecture.md \
    FuncReqImplementationCheck.md \
    FuncReqPolicyChecker.md \
    FuncReqMetadataFixer.md \
    FuncReqReporter.md \
    StyleGuide.md \
    Conclusion.md
do
    if [ -f "${report}" ] ; then
        cat "${report}" >> "tmp_${phase1_report_basename}.md"
    else
        echo "Warning: ${report} is missing"
    fi
done

# Report on conformance check registry
echo "" > "tmp_${conformance_check_appendix_basename}.md"
cat ConformityChecks/ConformanceChecksHeader.md >> "tmp_${conformance_check_appendix_basename}.md"
echo "" >> "tmp_${conformance_check_appendix_basename}.md"
cat ConformityChecks/ConformanceCheckRegistry.md >> "tmp_${conformance_check_appendix_basename}.md"
echo "" >> "tmp_${conformance_check_appendix_basename}.md"

echo "## Matroska Conformance Checks (Draft)" >> "tmp_${conformance_check_appendix_basename}.md"
cat ConformityChecks/ConformanceChecksMatroska.csv | csvprintf -i '### %1$s\n\n|Descriptor|Value|\n|:---------|:----|\n|CCID|%2$s|\n|Version|%3$s|\n|Authority|%4$s|\n|Target Format|%5$s|\n|Target Format Version|%6$s|\n|Target Format Part|%7$s|\n|Citation|%8$s|\n\nRule Clarity:    %10$s\n\nQuote:\n    %9$s\n\nDefinition:\n    %11$s\n\n\n'  >> "tmp_${conformance_check_appendix_basename}.md"

echo "## FFV1 Conformance Checks (Draft)" >> "tmp_${conformance_check_appendix_basename}.md"
cat ConformityChecks/ConformanceChecksFFV1.csv | csvprintf -i '### %1$s\n\n|Descriptor|Value|\n|:---------|:----|\n|CCID|%2$s|\n|Version|%3$s|\n|Authority|%4$s|\n|Target Format|%5$s|\n|Target Format Version|%6$s|\n|Target Format Part|%7$s|\n|Citation|%8$s|\n\nRule Clarity:    %10$s\n\nQuote:\n    %9$s\n\nDefinition:\n    %11$s\n\n\n'  >> "tmp_${conformance_check_appendix_basename}.md"

echo "## LPCM Conformance Checks (Draft)" >> "tmp_${conformance_check_appendix_basename}.md"
cat ConformityChecks/ConformanceChecksLPCM.csv | csvprintf -i '### %1$s\n\n|Descriptor|Value|\n|:---------|:----|\n|CCID|%2$s|\n|Version|%3$s|\n|Authority|%4$s|\n|Target Format|%5$s|\n|Target Format Version|%6$s|\n|Target Format Part|%7$s|\n|Citation|%8$s|\n\nRule Clarity:\n    %10$s\n\nQuote:\n    %9$s\n\nDefinition:\n    %11$s\n\n\n'  >> "tmp_${conformance_check_appendix_basename}.md"

echo "## Container/Stream Coherency Checks (Draft)" >> "tmp_${conformance_check_appendix_basename}.md"
cat ConformityChecks/CoherencyChecks.csv | csvprintf -i '### %1$s\n\n|Descriptor|Value|\n|:---------|:----|\n|CCID|%2$s|\n|Version|%3$s|\n|Authority|%4$s|\n|Target Format|%5$s|\n|Target Format Version|%6$s|\n|Target Format Part|%7$s|\n|Citation|%8$s|\n\nRule Clarity:\n    %10$s\n\nQuote:\n    %9$s\n\nDefinition:\n    %11$s\n\n\n'  >> "tmp_${conformance_check_appendix_basename}.md"

# Appendix on Standardization

echo "" > "tmp_${standardization_appendix_basename}.md"
for report in \
    StandardsIntroduction.md \
    StandardsNarrative.md
do
    if [ -f "${report}" ] ; then
        cat "${report}" >> "tmp_${standardization_appendix_basename}.md"
    else
        echo "Warning: ${report} is missing"
    fi
done

for reportbase in \
    "${phase1_report_basename}" \
    "${conformance_check_appendix_basename}" \
    "${standardization_appendix_basename}"
do
    toc "tmp_${reportbase}.md"
    pandoc -V geometry:margin=1in -V papersize:"a4paper" -o "ProjectReports/${reportbase}.pdf" "tmp_${reportbase}.md"
    pandoc -o "ProjectReports/${reportbase}.html" "tmp_${reportbase}.md"
done
cd "${pwd}"
