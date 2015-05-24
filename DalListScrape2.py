from bs4 import BeautifulSoup
from selenium import webdriver
import requests
import re
import csv
import time

with open('DalListings.csv','w',newline='') as fp:
    a = csv.writer(fp,delimiter=',')
    data = [['Neighborhood', 'Beds', 'Baths', 'Size', 'City', 'Zipcode', 'Type', 'Price']]
    a.writerows(data)

    for j in range(60,70):
        driver = webdriver.Firefox()
        driver.get('http://www.trulia.com/for_sale/Dallas,TX/'+str(j)+'_p')

        time.sleep(15)

        html = driver.page_source
        soup = BeautifulSoup(html)

        data = soup.findAll('div',{"class":"line mvn"})

        datavec = []

        for item in data:
            datavec.append(item.contents)

        neighstr = []
        bathstr = []
        bedstr = []
        sizestr = []
        citystr = []
        zipstr = []
        typestr = []
        pricestr = []

        for i in range(0,len(datavec)):
            try:
                neighstr.append(re.search(r'typeTruncate"><strong>.+?</strong>',str(datavec[i])).group())
            except:
                neighstr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                citystr.append(re.search(r'addressLocality">.+?</span>',str(datavec[i])).group())
            except:
                citystr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                zipstr.append(re.search(r'postalCode">.+?</span>',str(datavec[i])).group())
            except:
                zipstr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                bedstr.append(re.search(r'.+? beds',str(datavec[i])).group())
            except:
                bedstr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                bathstr.append(re.search(r'.+? baths',str(datavec[i])).group())
            except:
                bathstr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                sizestr.append(re.search(r'.+? sqft',str(datavec[i])).group())
            except:
                sizestr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                typestr.append(re.search(r'typeTruncate">\n<strong>.+?</strong>',str(datavec[i])).group())
            except:
                typestr.append('N/A')

        for i in range(0,len(datavec)):
            try:
                pricestr.append(re.search(r'value=\d+',str(datavec[i])).group())
            except:
                pricestr.append('N/A')


        for i in range(0,len(neighstr)):
            indata = [[neighstr[i], bedstr[i], bathstr[i], sizestr[i], citystr[i], zipstr[i], typestr[i], pricestr[i]]]
            a.writerows(indata)
            i+=1
        j+=1
        driver.quit()
