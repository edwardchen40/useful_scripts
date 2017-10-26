#!/usr/bin/python
# coding=utf-8
import os
import sys
import json
import datetime
import requests
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
sys.path.append(os.path.join(os.path.dirname(__file__), '../../', 'util-lib'))
from ResponseChecker import ResponseChecker, ResponseError
from random import randint
from numpy import random
from faker import Faker


class MovieAPI:
    """
    Class for Movie API
    """

    def __init__(self):
        self.rest_api_host = BuiltIn().get_variable_value("${REST_API_SERVER}")
        self.rest_api_host = self.rest_api_host + '/api'

        self.country = BuiltIn().get_variable_value("${COUNTRY}")
        cc_cookies = BuiltIn().get_variable_value("${CC_COOKIES}")
        self.cookies = dict(cookies_are=cc_cookies)
        self.headers = {"Cookie": cc_cookies}
        self.env = BuiltIn().get_variable_value("${ENV}")
        self.fake = Faker('zh_TW')

    def add_movie_info(self, movie_id, releaseDate, lang=None, certificate_type=None, movieTitle=None, broadcastStatus=None):
        """
        This function is to add movie information
        note:
        lang: en_US, zh_TW, fr_FR, ko_KR, ja_JP,
	    certificate: GENERAL 普遍級,PARENTAL_GUIDANCE 保護級, PARENTAL_GUIDANCE_12 輔導級, PARENTAL_GUIDANCE_15 輔導級
                     RESTRICTED 限制級
        broadcastStatus : "IN_THEATERS","OUT_THEATERS","COMING_SOON"
        """
        api_url = '{api_host}/movie/add'.format(api_host=self.rest_api_host)

        st = datetime.datetime.utcnow()
        ext_title = movieTitle
        if ext_title is None:
            ext_title = "Dummy Movie Title - QA 錢不夠花" + " - " + str(st)
        else:
            ext_title = movieTitle.encode('utf-8') + " - " + str(st)

        ext_engTitle = "Dummy Movie Title - QA money no enough so sad"
        ext_runTime = randint(90, 180)
        ext_showTimeCount = randint(10, 3000)

        obsThumbnail = {
                            "_id": "159cd47608ea28a5bddc9138t07096e50",
                            "name": "http://line.infotimes.com.tw/imagefull/919/L_200905Money_172_17_116_106.jpg",
                            "type": "IMAGE",
                            "obsId": "159cd47608ea28a5bddc9138t07096e50",
                            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47608ea28a5bddc9138t07096e50",
                            "obsThumbnails": {
                                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47608ea28a5bddc9138t07096e50/w580",
                                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47608ea28a5bddc9138t07096e50/f198",
                                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47608ea28a5bddc9138t07096e50/w644"
                            },
                            "cdnHash": "0hpmiyfOG8L0JUAADoHjdQFWtWLC1nbDxBMDZ-JHUIIyd8Nm8VYTIwJ3hQdSEsZTocaGRpYXAGcHp-ZGwV",
                            "cdnUrl": "https://obs-beta.line-apps.com/0hpmiyfOG8L0JUAADoHjdQFWtWLC1nbDxBMDZ-JHUIIyd8Nm8VYTIwJ3hQdSEsZTocaGRpYXAGcHp-ZGwV",
                            "cdnThumbnails": {
                                "w580": "https://obs-beta.line-apps.com/0hpmiyfOG8L0JUAADoHjdQFWtWLC1nbDxBMDZ-JHUIIyd8Nm8VYTIwJ3hQdSEsZTocaGRpYXAGcHp-ZGwV/w580",
                                "f198": "https://obs-beta.line-apps.com/0hpmiyfOG8L0JUAADoHjdQFWtWLC1nbDxBMDZ-JHUIIyd8Nm8VYTIwJ3hQdSEsZTocaGRpYXAGcHp-ZGwV/f198",
                                "w644": "https://obs-beta.line-apps.com/0hpmiyfOG8L0JUAADoHjdQFWtWLC1nbDxBMDZ-JHUIIyd8Nm8VYTIwJ3hQdSEsZTocaGRpYXAGcHp-ZGwV/w644"
                            }
                        }

        obsPictures = [{
            "_id": "159cd47618e9d752bddc9146t07096e51",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_001_172_17_116_106.jpg",
            "type": "IMAGE",
            "obsId": "159cd47618e9d752bddc9146t07096e51",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47618e9d752bddc9146t07096e51",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47618e9d752bddc9146t07096e51/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47618e9d752bddc9146t07096e51/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47618e9d752bddc9146t07096e51/w644"
            },
            "cdnHash": "0huUVQI3WqKnprKAXQIR5VLVR-KRVYRDl5Dx57HEogJh9DHmosXhptSUgsdxkTTT8kV0tiWU8udUJBTGks",
            "cdnUrl": "https://obs-beta.line-apps.com/0huUVQI3WqKnprKAXQIR5VLVR-KRVYRDl5Dx57HEogJh9DHmosXhptSUgsdxkTTT8kV0tiWU8udUJBTGks",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0huUVQI3WqKnprKAXQIR5VLVR-KRVYRDl5Dx57HEogJh9DHmosXhptSUgsdxkTTT8kV0tiWU8udUJBTGks/w580",
                "f198": "https://obs-beta.line-apps.com/0huUVQI3WqKnprKAXQIR5VLVR-KRVYRDl5Dx57HEogJh9DHmosXhptSUgsdxkTTT8kV0tiWU8udUJBTGks/f198",
                "w644": "https://obs-beta.line-apps.com/0huUVQI3WqKnprKAXQIR5VLVR-KRVYRDl5Dx57HEogJh9DHmosXhptSUgsdxkTTT8kV0tiWU8udUJBTGks/w644"
            }
        }, {
            "_id": "159cd47648e126e1bddc9159t07096e54",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_002_172_17_116_106.jpg",
            "type": "IMAGE",
            "obsId": "159cd47648e126e1bddc9159t07096e54",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47648e126e1bddc9159t07096e54",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47648e126e1bddc9159t07096e54/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47648e126e1bddc9159t07096e54/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47648e126e1bddc9159t07096e54/w644"
            },
            "cdnHash": "0h8UgQhN0hZ3paKEjQEBsYLWV-ZBVpRHR5Ph42HHsgax9yHicpbxooH3h8ORkiTXIkZkogWX4uOEJwTCQp",
            "cdnUrl": "https://obs-beta.line-apps.com/0h8UgQhN0hZ3paKEjQEBsYLWV-ZBVpRHR5Ph42HHsgax9yHicpbxooH3h8ORkiTXIkZkogWX4uOEJwTCQp",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0h8UgQhN0hZ3paKEjQEBsYLWV-ZBVpRHR5Ph42HHsgax9yHicpbxooH3h8ORkiTXIkZkogWX4uOEJwTCQp/w580",
                "f198": "https://obs-beta.line-apps.com/0h8UgQhN0hZ3paKEjQEBsYLWV-ZBVpRHR5Ph42HHsgax9yHicpbxooH3h8ORkiTXIkZkogWX4uOEJwTCQp/f198",
                "w644": "https://obs-beta.line-apps.com/0h8UgQhN0hZ3paKEjQEBsYLWV-ZBVpRHR5Ph42HHsgax9yHicpbxooH3h8ORkiTXIkZkogWX4uOEJwTCQp/w644"
            }
        }, {
            "_id": "159cd47658e2eb22bddc9167t07096e56",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_003_172_17_116_106.jpg",
            "type": "IMAGE",
            "obsId": "159cd47658e2eb22bddc9167t07096e56",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47658e2eb22bddc9167t07096e56",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47658e2eb22bddc9167t07096e56/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47658e2eb22bddc9167t07096e56/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47658e2eb22bddc9167t07096e56/w644"
            },
            "cdnHash": "0hxjoSCPusJ0VSKgjvGBtYEm18JCphRjRGNhx2I3MiKyB6HGcXZxhrdyQpeiYqTzIbbktuZnYseH14TmQU",
            "cdnUrl": "https://obs-beta.line-apps.com/0hxjoSCPusJ0VSKgjvGBtYEm18JCphRjRGNhx2I3MiKyB6HGcXZxhrdyQpeiYqTzIbbktuZnYseH14TmQU",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hxjoSCPusJ0VSKgjvGBtYEm18JCphRjRGNhx2I3MiKyB6HGcXZxhrdyQpeiYqTzIbbktuZnYseH14TmQU/w580",
                "f198": "https://obs-beta.line-apps.com/0hxjoSCPusJ0VSKgjvGBtYEm18JCphRjRGNhx2I3MiKyB6HGcXZxhrdyQpeiYqTzIbbktuZnYseH14TmQU/f198",
                "w644": "https://obs-beta.line-apps.com/0hxjoSCPusJ0VSKgjvGBtYEm18JCphRjRGNhx2I3MiKyB6HGcXZxhrdyQpeiYqTzIbbktuZnYseH14TmQU/w644"
            }
        }, {
            "_id": "159cd47678ea1c10bddc9177t07096e58",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_004_172_17_116_106.jpg",
            "type": "IMAGE",
            "obsId": "159cd47678ea1c10bddc9177t07096e58",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47678ea1c10bddc9177t07096e58",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47678ea1c10bddc9177t07096e58/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47678ea1c10bddc9177t07096e58/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47678ea1c10bddc9177t07096e58/w644"
            },
            "cdnHash": "0hF850YsmTGRcISTa9QnZmQDcfGng7JQoUbH9IcSlBFXIgf1lHPXsGcX9JRnRwLAxJNClQNCxPRi8iLVpI",
            "cdnUrl": "https://obs-beta.line-apps.com/0hF850YsmTGRcISTa9QnZmQDcfGng7JQoUbH9IcSlBFXIgf1lHPXsGcX9JRnRwLAxJNClQNCxPRi8iLVpI",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hF850YsmTGRcISTa9QnZmQDcfGng7JQoUbH9IcSlBFXIgf1lHPXsGcX9JRnRwLAxJNClQNCxPRi8iLVpI/w580",
                "f198": "https://obs-beta.line-apps.com/0hF850YsmTGRcISTa9QnZmQDcfGng7JQoUbH9IcSlBFXIgf1lHPXsGcX9JRnRwLAxJNClQNCxPRi8iLVpI/f198",
                "w644": "https://obs-beta.line-apps.com/0hF850YsmTGRcISTa9QnZmQDcfGng7JQoUbH9IcSlBFXIgf1lHPXsGcX9JRnRwLAxJNClQNCxPRi8iLVpI/w644"
            }
        }, {
            "_id": "159cd47698ebb79abddc9184t07096e59",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_005_172_17_116_106.JPG",
            "type": "IMAGE",
            "obsId": "159cd47698ebb79abddc9184t07096e59",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47698ebb79abddc9184t07096e59",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47698ebb79abddc9184t07096e59/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47698ebb79abddc9184t07096e59/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47698ebb79abddc9184t07096e59/w644"
            },
            "cdnHash": "0hBXKkG5VNHXd2EjLdPCxiIElEHhhFfg50EiRMEVcaERJeJF0pQyABQlUaExQOdwgpSn1XVFIUQk9cdl4p",
            "cdnUrl": "https://obs-beta.line-apps.com/0hBXKkG5VNHXd2EjLdPCxiIElEHhhFfg50EiRMEVcaERJeJF0pQyABQlUaExQOdwgpSn1XVFIUQk9cdl4p",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hBXKkG5VNHXd2EjLdPCxiIElEHhhFfg50EiRMEVcaERJeJF0pQyABQlUaExQOdwgpSn1XVFIUQk9cdl4p/w580",
                "f198": "https://obs-beta.line-apps.com/0hBXKkG5VNHXd2EjLdPCxiIElEHhhFfg50EiRMEVcaERJeJF0pQyABQlUaExQOdwgpSn1XVFIUQk9cdl4p/f198",
                "w644": "https://obs-beta.line-apps.com/0hBXKkG5VNHXd2EjLdPCxiIElEHhhFfg50EiRMEVcaERJeJF0pQyABQlUaExQOdwgpSn1XVFIUQk9cdl4p/w644"
            }
        }, {
            "_id": "159cd476a8e389e0bddc9186t07096e5a",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_006_172_17_116_106.JPG",
            "type": "IMAGE",
            "obsId": "159cd476a8e389e0bddc9186t07096e5a",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd476a8e389e0bddc9186t07096e5a",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd476a8e389e0bddc9186t07096e5a/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd476a8e389e0bddc9186t07096e5a/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd476a8e389e0bddc9186t07096e5a/w644"
            },
            "cdnHash": "0hWow2uk6SCEBKSyfqAHZ3F3UdCy95JxtDLn1ZJmtDBCVifUhGf3lFL2cfVyMyLh0ediRAY25NV3hgL0tG",
            "cdnUrl": "https://obs-beta.line-apps.com/0hWow2uk6SCEBKSyfqAHZ3F3UdCy95JxtDLn1ZJmtDBCVifUhGf3lFL2cfVyMyLh0ediRAY25NV3hgL0tG",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hWow2uk6SCEBKSyfqAHZ3F3UdCy95JxtDLn1ZJmtDBCVifUhGf3lFL2cfVyMyLh0ediRAY25NV3hgL0tG/w580",
                "f198": "https://obs-beta.line-apps.com/0hWow2uk6SCEBKSyfqAHZ3F3UdCy95JxtDLn1ZJmtDBCVifUhGf3lFL2cfVyMyLh0ediRAY25NV3hgL0tG/f198",
                "w644": "https://obs-beta.line-apps.com/0hWow2uk6SCEBKSyfqAHZ3F3UdCy95JxtDLn1ZJmtDBCVifUhGf3lFL2cfVyMyLh0ediRAY25NV3hgL0tG/w644"
            }
        }, {
            "_id": "159cd476c8ecb2fcbddc9188t07096e5c",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_007_172_17_116_106.JPG",
            "type": "IMAGE",
            "obsId": "159cd476c8ecb2fcbddc9188t07096e5c",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd476c8ecb2fcbddc9188t07096e5c",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd476c8ecb2fcbddc9188t07096e5c/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd476c8ecb2fcbddc9188t07096e5c/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd476c8ecb2fcbddc9188t07096e5c/w644"
            },
            "cdnHash": "0hNviIBVzMEVlUMD7zHgtuDmtmEjZnXAJaMAZAP3U4HTx8BlFdYQIMbHJnHTosVQQHaF9XenA2TmF-VFJd",
            "cdnUrl": "https://obs-beta.line-apps.com/0hNviIBVzMEVlUMD7zHgtuDmtmEjZnXAJaMAZAP3U4HTx8BlFdYQIMbHJnHTosVQQHaF9XenA2TmF-VFJd",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hNviIBVzMEVlUMD7zHgtuDmtmEjZnXAJaMAZAP3U4HTx8BlFdYQIMbHJnHTosVQQHaF9XenA2TmF-VFJd/w580",
                "f198": "https://obs-beta.line-apps.com/0hNviIBVzMEVlUMD7zHgtuDmtmEjZnXAJaMAZAP3U4HTx8BlFdYQIMbHJnHTosVQQHaF9XenA2TmF-VFJd/f198",
                "w644": "https://obs-beta.line-apps.com/0hNviIBVzMEVlUMD7zHgtuDmtmEjZnXAJaMAZAP3U4HTx8BlFdYQIMbHJnHTosVQQHaF9XenA2TmF-VFJd/w644"
            }
        }, {
            "_id": "159cd476e8e9c203bddc9190t07096e5e",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_008_172_17_116_106.jpg",
            "type": "IMAGE",
            "obsId": "159cd476e8e9c203bddc9190t07096e5e",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd476e8e9c203bddc9190t07096e5e",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd476e8e9c203bddc9190t07096e5e/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd476e8e9c203bddc9190t07096e5e/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd476e8e9c203bddc9190t07096e5e/w644"
            },
            "cdnHash": "0h70-fGGozaB8QH0e1WiYXSC9Ja3Ajc3scdCk5eTEXZHo4KSgdJS0vKzYeNHxoen1BLHEmPDQZNyc6eysd",
            "cdnUrl": "https://obs-beta.line-apps.com/0h70-fGGozaB8QH0e1WiYXSC9Ja3Ajc3scdCk5eTEXZHo4KSgdJS0vKzYeNHxoen1BLHEmPDQZNyc6eysd",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0h70-fGGozaB8QH0e1WiYXSC9Ja3Ajc3scdCk5eTEXZHo4KSgdJS0vKzYeNHxoen1BLHEmPDQZNyc6eysd/w580",
                "f198": "https://obs-beta.line-apps.com/0h70-fGGozaB8QH0e1WiYXSC9Ja3Ajc3scdCk5eTEXZHo4KSgdJS0vKzYeNHxoen1BLHEmPDQZNyc6eysd/f198",
                "w644": "https://obs-beta.line-apps.com/0h70-fGGozaB8QH0e1WiYXSC9Ja3Ajc3scdCk5eTEXZHo4KSgdJS0vKzYeNHxoen1BLHEmPDQZNyc6eysd/w644"
            }
        }, {
            "_id": "159cd476f8ec40b8bddc9192t07096e5f",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_009_172_17_116_106.JPG",
            "type": "IMAGE",
            "obsId": "159cd476f8ec40b8bddc9192t07096e5f",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd476f8ec40b8bddc9192t07096e5f",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd476f8ec40b8bddc9192t07096e5f/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd476f8ec40b8bddc9192t07096e5f/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd476f8ec40b8bddc9192t07096e5f/w644"
            },
            "cdnHash": "0hUMsvIMnkCmJODyXIBDd1NXFZCQ19YxlhKjlbBG8HBgdmOUpjez0XAWpcXQE2ah88cmFGQWoJVVpka0lj",
            "cdnUrl": "https://obs-beta.line-apps.com/0hUMsvIMnkCmJODyXIBDd1NXFZCQ19YxlhKjlbBG8HBgdmOUpjez0XAWpcXQE2ah88cmFGQWoJVVpka0lj",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hUMsvIMnkCmJODyXIBDd1NXFZCQ19YxlhKjlbBG8HBgdmOUpjez0XAWpcXQE2ah88cmFGQWoJVVpka0lj/w580",
                "f198": "https://obs-beta.line-apps.com/0hUMsvIMnkCmJODyXIBDd1NXFZCQ19YxlhKjlbBG8HBgdmOUpjez0XAWpcXQE2ah88cmFGQWoJVVpka0lj/f198",
                "w644": "https://obs-beta.line-apps.com/0hUMsvIMnkCmJODyXIBDd1NXFZCQ19YxlhKjlbBG8HBgdmOUpjez0XAWpcXQE2ah88cmFGQWoJVVpka0lj/w644"
            }
        }, {
            "_id": "159cd47718e707d2bddc9196t07096e62",
            "name": "http://line.infotimes.com.tw/imagefull/919/M_200905Money_010_172_17_116_106.JPG",
            "type": "IMAGE",
            "obsId": "159cd47718e707d2bddc9196t07096e62",
            "obsUrl": "https://obs-beta.line-apps.com/r/gln/media/159cd47718e707d2bddc9196t07096e62",
            "obsThumbnails": {
                "w580": "https://obs-beta.line-apps.com/r/gln/media/159cd47718e707d2bddc9196t07096e62/w580",
                "f198": "https://obs-beta.line-apps.com/r/gln/media/159cd47718e707d2bddc9196t07096e62/f198",
                "w644": "https://obs-beta.line-apps.com/r/gln/media/159cd47718e707d2bddc9196t07096e62/w644"
            },
            "cdnHash": "0hycDAil_wJkx5OAnmMx1ZG0ZuJSNKVDVPHQ53KlgwKilRDmcaTApvK1ptey8BXTMSRVZub10-eXRTXGYZ",
            "cdnUrl": "https://obs-beta.line-apps.com/0hycDAil_wJkx5OAnmMx1ZG0ZuJSNKVDVPHQ53KlgwKilRDmcaTApvK1ptey8BXTMSRVZub10-eXRTXGYZ",
            "cdnThumbnails": {
                "w580": "https://obs-beta.line-apps.com/0hycDAil_wJkx5OAnmMx1ZG0ZuJSNKVDVPHQ53KlgwKilRDmcaTApvK1ptey8BXTMSRVZub10-eXRTXGYZ/w580",
                "f198": "https://obs-beta.line-apps.com/0hycDAil_wJkx5OAnmMx1ZG0ZuJSNKVDVPHQ53KlgwKilRDmcaTApvK1ptey8BXTMSRVZub10-eXRTXGYZ/f198",
                "w644": "https://obs-beta.line-apps.com/0hycDAil_wJkx5OAnmMx1ZG0ZuJSNKVDVPHQ53KlgwKilRDmcaTApvK1ptey8BXTMSRVZub10-eXRTXGYZ/w644"
            }
        }]

        # Check broadcastStatus
        ext_broadcastStatus = broadcastStatus
        broadcastStatus_list = ["IN_THEATERS", "OUT_THEATERS", "COMING_SOON"]

        if ext_broadcastStatus is None:
            ext_broadcastStatus = random.choice(broadcastStatus_list, randint(1, 1))[0]

        # Check certificate_type
        ext_certificate = certificate_type
        certificate_list = ["GENERAL", "PARENTAL_GUIDANCE", "PARENTAL_GUIDANCE_12",
                            "PARENTAL_GUIDANCE_15", "RESTRICTED"]
        if certificate_type is None:
            ext_certificate = random.choice(certificate_list, randint(1, 1))[0]

        # Generate fake name
        directors = []
        cast = []
        if lang is None:
            for i in range(1, randint(2, 6)):
                directors.append(self.fake.name())
                cast.append(self.fake.name())
        else:
            self.fake = Faker(lang)
            for i in range(1, randint(2, 6)):
                directors.append(self.fake.name())
                cast.append(self.fake.name())

        genres = ["喜劇", "劇情", "家庭", "紀錄片", "音樂", "懸疑驚悚", "冒險", "靈異", "動作", "動畫"]
        ext_genres = random.choice(genres, randint(1, 6), replace=False).tolist()
        payload = {
            "id": str(movie_id),
            "_class": "com.linecorp.news.core.domain.movie.Movie",
            "country": str(self.country),
            "title": str(ext_title),
            "engTitle": str(ext_engTitle),
            "obsThumbnail": obsThumbnail,
            "releaseDate" : releaseDate,
            "runtime": ext_runTime,
            "certificate": ext_certificate,
            "director": directors,
            "cast": cast,
            "genres": ext_genres,
            "obsPictures": obsPictures,
            "synopsis": "* 狂賀! QA 強檔鉅獻<br/><br/>* GD 哥強勢回歸",
            "distributor": "台灣連線不連線娛樂公司",
            "showtimeCount": int(ext_showTimeCount),
            "broadcastStatus": str(ext_broadcastStatus)
        }

        res = requests.post(api_url, headers=self.headers,
                            json=payload, cookies=self.cookies)
        ResponseChecker(res)
        try:
            return res.json().get("result")
        except:
            raise ResponseError("Parsing data error")
