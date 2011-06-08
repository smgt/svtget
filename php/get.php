<?php

$i=1;
define('SVTGET__INVALID_URL', $i++);
define('SVTGET__BAD_URL_SCHEME', $i++);
define('SVTGET__BAD_URL_HOST', $i++);

if ( !function_exists('http_bad_request') ) {
function http_error($errno, $str='Bad Request') {
	header('HTTP/1.1 '.(0+$errno).' '.urlencode($str));
	header('Status: '.(0+$errno).' '.urlencode($str));
	echo $str;
	die;
}
}

function svtget_parse_url($url) {

	$url = parse_url($url);
	if ( empty($url) )
		throw new Exception('GET or POST with valid URL in variable url', SVTGET__INVALID_URL);

	if ( $url['scheme'] != 'http' )
		throw new Exception('URL must have scheme http', SVTGET__BAD_URL_SCHEME);

	if ( $url['host'] != 'svtplay.se' )
		throw new Exception('Only host svtplay.se supported currently', SVTGET__BAD_URL_HOST);

	return "{$url['scheme']}://{$url['host']}{$url['path']}";
}

function get_url_contents($url) {
	$ctrl = curl_init();
	curl_setopt ( $ctrl, CURLOPT_URL, $url );
	curl_setopt ( $ctrl, CURLOPT_RETURNTRANSFER, true );
	curl_setopt ( $ctrl, CURLOPT_CONNECTTIMEOUT, 5 );
	$html = curl_exec($ctrl);
	curl_close($ctrl);
	return $html;
}

function get_swfUrl($html) {
	if ( ! preg_match ('/data="([^"]+.swf)"/', $html, $swf) )
		throw new Exception('Unable to find player swf, is URL working?');

	return 'http://svtplay.se'.$swf[1];
}

function get_rtmp_streams($html) {
	if ( ! preg_match_all('/rtmp[e]?:[^|&]+,bitrate:[0-9]+/', $html, $choices) )
		throw new Exception('No rtmp streams found, does URL contain clips?');

	$streams = array();
	foreach ( array_unique($choices[0]) as $stream )
		$streams[] = explode(',bitrate:', $stream);

	return $streams;
}

try {
	$pageUrl = svtget_parse_url($_GET['url']);
	$html = get_url_contents($pageUrl);
	$swfUrl = get_swfUrl($html);
	$streams = get_rtmp_streams($html);
} catch (Exception $e) {
	http_error(400, $e->getmessage());
}
	
	$program_name = basename($url);
	/* pageUrl, swfUrl, tcUrl are names from Adobe RTMP specification */
	$svtget_result = array(
		'app' => 'SVT Play',
		'program_name' => $program_name,
		'pageUrl' => $pageUrl,
		'swfUrl' => $swfUrl,
		'tcUrls' => $streams,
		);

	echo json_encode($svtget_result);
