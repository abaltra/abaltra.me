deploy:
	cd site
	aws s3 sync site/ s3://abaltra.me --profile abaltra