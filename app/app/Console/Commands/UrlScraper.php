<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Url;
use \GuzzleHttp\Client;

class UrlScraper extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'moveinsync:url_scraper';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */

    public function handle() {
        ini_set('memory_limit', "1024M");
        $retries = env("RETRIES_THRESHOLD", "3");

        echo "Welcome to UrlScraper Microservice..";
        echo "\nWorker Started";
        
        $flag = true;
        while(true) {
            
            $url = Url::where('is_processed', 0)->where('is_processing', 0)->first();
            $this->url = $url;
            if(!empty($url)) {
               
                $url->is_processing = 1;
                $url->save();
                echo "\n\nProcessing url : ".$url->url;
                $flag = true;
                $this->processUrl($url, $retries);
            } else {
                sleep(2);
                $this->url = false;
                if($flag) {
                    echo "\nAll urls processed... \nWaiting for new urls...";
                    $flag = false;
                }
            }
        }
          
        
    }

    /**
     * Process Url for the specified number of retries
     *
     * @var string
     * @return mixed
     */
    public function processUrl($url, $retries) {
   
        for($i = 0; $i < $retries; $i++) {
            try {
                $response = $this->customGetRequest($url->url);

                $url->response = $response;
                $url->is_processing = 0;
                $url->is_processed = 1;
                $url->save();
                return;
            } catch(\Exception $e) {
                echo "\nRetrying Attempt - ".($i+1);
            }
        } 

        echo "\nReached Threshold number of retries.... Scraping Failed...";
        echo "\n".$e->getMessage();
        
        $url->error_message = $e->getMessage();
        $url->http_error_code = $e->getCode();
        $url->is_processing = 0;
        $url->is_processed = 1;
        $url->is_failed = 1;

        $url->save();
    }



    /**
     * Hit The specified url and return the response
     *
     * @var string
     * @return mixed
     */
    public function customGetRequest($url){
        
        $client = new Client();

        $response = $client->get($url);
       
        $result =  $response->getBody()->getContents();
        
        return $result;
    }

    // public function shutdown()
    // {
    //     $this->info('Gracefully stopping worker...');
    //     // When set to false, worker will finish current item and stop.

    //     if(!empty($this->url)) {
    //         $this->url->is_processing = 0;
    //         $this->url->save();
    //     }

    //     $this->info('Bye!');
    // }

}
