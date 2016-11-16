#!/usr/bin/python
import sys
sys.path.insert(0, 'wiibalance_live/python/build/lib.linux-i686-2.6/')
import cwiid
import sys
import httplib, urllib
import gobject
import thread, time 


def new_main():
        #Connect to address given on command-line, if present
        print 'Put Wiimote in discoverable mode now (press 1+2)...and slap on the keg!'
        global wiimote
        if len(sys.argv) > 1:
                wiimote = cwiid.Wiimote(sys.argv[1])
        else:
                wiimote = cwiid.Wiimote()

        wiimote.rpt_mode = cwiid.RPT_BALANCE | cwiid.RPT_BTN
        wiimote.request_status()

        #if wiimote.state['ext_type'] != cwiid.EXT_BALANCE:
                #print 'This program only supports the Wii Balance Board'
                #wiimote.close()
                #return -1

        balance_calibration = wiimote.get_balance_cal()
        named_calibration = { 'right_top': balance_calibration[0],
                                                  'right_bottom': balance_calibration[1],
                                                  'left_top': balance_calibration[2],
                                                  'left_bottom': balance_calibration[3],
                                                }  
	thread.start_new_thread(timer, ())
	return 0

def main():
	#Connect to address given on command-line, if present
	print 'Put Wiimote in discoverable mode now (press 1+2)...and slap on the keg!'
	global wiimote
	if len(sys.argv) > 1:
		wiimote = cwiid.Wiimote(sys.argv[1])
	else:
		wiimote = cwiid.Wiimote()
	
	wiimote.rpt_mode = cwiid.RPT_BALANCE | cwiid.RPT_BTN
	wiimote.request_status()

		
	#	wiimote.close()
	#	return -1

	balance_calibration = wiimote.get_balance_cal()
	named_calibration = { 'right_top': balance_calibration[0],
						  'right_bottom': balance_calibration[1],
						  'left_top': balance_calibration[2],
						  'left_bottom': balance_calibration[3],
						}

	exit = False
	while not exit:
		#print "Type q to quit, or anything else to report your weight"
                c = sys.stdin.read(1)
		if c == 'q':
			exit = True
	        print "Sending weight to g5keg.herokuapp.com\n"	
                wiimote.request_status()
                weight = str("%.2f" % (calcweight(wiimote.state['balance'], named_calibration) / 100.0, ))
		print weight + "kg"
		print "\nAnd now for our curl...\n"
	        params = urllib.urlencode({'kg': weight})	
                headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
		conn = httplib.HTTPConnection("g5keg.herokuapp.com")
                url = "/kegs/current_weight"  
                conn.request("POST", url, params, headers)
                response=conn.getresponse()
                print response.status, response.reason
	        #gobject.timeout_add(10*1000, my_timer)		
	        thread.start_new_thread(timer, ())		

	return 0

def timer():
  while True:
        	balance_calibration = wiimote.get_balance_cal()
        	named_calibration = { 'right_top': balance_calibration[0],
                                                  'right_bottom': balance_calibration[1],
                                                  'left_top': balance_calibration[2],
                                                  'left_bottom': balance_calibration[3],
                                                }	
		time.sleep(60)
    	        print "I am a timer...\n"	
		wiimote.request_status() 
                weight = str("%.2f" % (calcweight(wiimote.state['balance'], named_calibration) / 100.0, ))
                print weight + "kg\n"
                print "\nAnd now for our curl...\n"
                params = urllib.urlencode({'kg': weight})
                headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
                conn = httplib.HTTPConnection("g5keg.herokuapp.com")
                url = "/kegs/current_weight"
                conn.request("POST", url, params, headers)
                response=conn.getresponse()
                print response.status, response.reason

def my_timer(*args):
                wiimote.request_status() 
                weight = str("%.2f" % (calcweight(wiimote.state['balance'], named_calibration) / 100.0, ))
                print weight + "kg"
                print "\nAnd now for our curl...\n"
                params = urllib.urlencode({'kg': weight})
                headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
                conn = httplib.HTTPConnection("g5keg.herokuapp.com")
                url = "/kegs/current_weight" 
                conn.request("POST", url, params, headers)
                response=conn.getresponse()
                print response.status, response.reason 
                return True 

def calcweight( readings, calibrations ):
	"""
	Determine the weight of the user on the board in hundredths of a kilogram
	"""
	weight = 0
	for sensor in ('right_top', 'right_bottom', 'left_top', 'left_bottom'):
		reading = readings[sensor]
		calibration = calibrations[sensor]
#		if reading < calibration[0]:
#			print "Warning, %s reading below lower calibration value" % sensor
		if reading > calibration[2]:
			print "Warning, %s reading above upper calibration value" % sensor
		# 1700 appears to be the step the calibrations are against.
		# 17kg per sensor is 68kg, 1/2 of the advertised Japanese weight limit.
		if reading < calibration[1]:
			weight += 1700 * (reading - calibration[0]) / (calibration[1] - calibration[0])
		else:
			weight += 1700 * (reading - calibration[1]) / (calibration[2] - calibration[1]) + 1700

	return weight

if __name__ == "__main__":
	sys.exit(main())
