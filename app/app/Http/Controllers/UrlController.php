<?php

namespace App\Http\Controllers;

use App\Url;

class UrlController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    //

    public function getFailedUrls() {
        $urls = Url::where('is_failed', 1)->get();
        
        $response = [];
        foreach ($urls as $url) {
            $response[] = [
                "url" => $url->url,
                "message" => $url->error_message,
                "statusCode" => $url->http_error_code
            ];
        }

        return $response;
    }
}
