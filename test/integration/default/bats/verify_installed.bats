@test 's3cmd installed' {
  which s3cmd
}

@test '.s3cfg contains correct secret_key' {
	grep foo /root/.s3cfg
}

@test '.s3cfg contains correct access_key' {
	grep bar /root/.s3cfg
}
