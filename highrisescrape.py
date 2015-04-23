from bs4 import BeautifulSoup
from selenium import webdriver
import requests
import re
import csv
import time

with open('DalCondos.csv','w',newline='') as fp:
    a = csv.writer(fp,delimiter=',')
    data = [['Name','Address','Location','Price','Summary']]
    a.writerows(data)

    for i in range(1,26):
        url = "http://www.highrises.com/dallas/idx/?p="+str(i)
        r = requests.get(url)
        soup = BeautifulSoup(r.content)

        data = soup.findAll('li', {"class":"data-address"})
        data2 = soup.findAll('li', {"class":"data-location"})
        data3 = soup.findAll('li', {"class":"data-price"})
        data4 = soup.findAll('li', {"class":"data-summary"})

        name = []
        address = []
        location = []
        price = []
        sumdata = []
    
        for item in data2:
            location.append(item.contents[0])

        for item in data3:
            price.append(item.contents[0])

        for item in data4:
            sumdata.append(item.contents)

        data5 = soup.findAll('ul', {"class":"dataset"})
        for item in data5:
            name.append(item.findAll('li', {"class":"data-address"})[0].text)
            try:
                address.append(item.findAll('li', {"class":"data-address"})[1].text)
            except:
                address.append("N/A")

        for i in range(0,len(name)):
            indata = [[name[i],address[i],location[i],price[i],sumdata[i]]]
            a.writerows(indata)
            i+=1

