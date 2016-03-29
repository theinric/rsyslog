#!/bin/bash
# added 2015-12-02 by singh.janmejay
# This file is part of the rsyslog project, released under ASL 2.0
echo ===============================================================================
echo \[lookup_table_bad_configs.sh\]: test for sparse-array lookup-table and HUP based reloading of it
. $srcdir/diag.sh init

echo "empty file..."
cp $srcdir/testsuites/xlate_empty_file.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh startup-vg lookup_table_all.conf
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty

echo "table with invalid-json..."
cp $srcdir/testsuites/xlate_invalid_json.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty

echo "string-table with no index-key..."
cp $srcdir/testsuites/xlate_string_no_index.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "foo"
. $srcdir/diag.sh assert-content-missing "bar"
. $srcdir/diag.sh assert-content-missing "baz"

echo "array-table with no index-key..."
cp $srcdir/testsuites/xlate_array_no_index.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "foo"
. $srcdir/diag.sh assert-content-missing "bar"
. $srcdir/diag.sh assert-content-missing "baz"

echo "sparse-array-table with no index-key..."
cp $srcdir/testsuites/xlate_sparseArray_no_index.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "foo"
. $srcdir/diag.sh assert-content-missing "bar"
. $srcdir/diag.sh assert-content-missing "baz"

echo "string-table with no value..."
cp $srcdir/testsuites/xlate_string_no_value.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "baz"

echo "array-table with no value..."
cp $srcdir/testsuites/xlate_array_no_value.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "baz"

echo "sparse-array-table with no value..."
cp $srcdir/testsuites/xlate_sparseArray_no_value.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "baz"

echo "incorrect-version in lookup-table..."
cp $srcdir/testsuites/xlate_incorrect_version.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "foo"
. $srcdir/diag.sh assert-content-missing "bar"
. $srcdir/diag.sh assert-content-missing "baz"

echo "incorrect-type in lookup-table..."
cp $srcdir/testsuites/xlate_incorrect_type.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "foo"
. $srcdir/diag.sh assert-content-missing "bar"
. $srcdir/diag.sh assert-content-missing "baz"

echo "string-table with no table..."
cp $srcdir/testsuites/xlate_string_no_table.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "baz"

echo "array-table with no table..."
cp $srcdir/testsuites/xlate_array_no_table.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "baz"

echo "sparse-array-table with no table..."
cp $srcdir/testsuites/xlate_sparseArray_no_table.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 5
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh assert-content-missing "baz"

echo "string-table with empty table..."
cp $srcdir/testsuites/xlate_string_empty_table.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 2
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh content-check "msgnum:00000000: baz_str"
. $srcdir/diag.sh content-check "msgnum:00000001: baz_str"

echo "array-table with empty table..."
cp $srcdir/testsuites/xlate_array_empty_table.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 2
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh content-check "msgnum:00000000: baz_arr"
. $srcdir/diag.sh content-check "msgnum:00000001: baz_arr"

echo "sparse-array-table with empty table..."
cp $srcdir/testsuites/xlate_sparseArray_empty_table.lkp_tbl $srcdir/xlate.lkp_tbl
. $srcdir/diag.sh issue-HUP
. $srcdir/diag.sh await-lookup-table-reload
. $srcdir/diag.sh injectmsg  0 2
. $srcdir/diag.sh wait-queueempty
. $srcdir/diag.sh content-check "msgnum:00000000: baz_sparse_arr"
. $srcdir/diag.sh content-check "msgnum:00000001: baz_sparse_arr"

echo doing shutdown
. $srcdir/diag.sh shutdown-when-empty
echo wait on shutdown
. $srcdir/diag.sh wait-shutdown-vg
. $srcdir/diag.sh check-exit-vg
. $srcdir/diag.sh exit
