# vim:fileencoding=utf-8:noet
import os
import requests

def pendant_record_status(pl, base_url='https://glassycollections.com', auth_token=None):
	url = base_url + '/api/my/pendant_record_status'
	response = requests.get(url, headers={'Authorization': auth_token})
	if response.status_code == 200:
		was_pendant_recorded = response.json()['pendant_recorded?']
		if was_pendant_recorded:
			return [{
					'contents': "Recorded",
					'highlight_groups': ['information:regular']
					}]
		else:
			return [{
					'contents': "Not Recorded",
					'highlight_groups': ['information:highlighted']
					}]
	else:
		return [{
				'contents': 'API Error',
				'highlight_groups': ['warning:regular']
				}]


