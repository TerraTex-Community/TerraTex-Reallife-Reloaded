playerJobMarkers = {}
muellmarkers = {}
local trashPoints = 0
deponieMarker = false
deponieBlip = false

function createMuellTable()
    table.insert(muellmarkers, { 2295.96484375, -2116.6435546875, 13.610626220703 })
    table.insert(muellmarkers, { 2102.3017578125, -2045.62109375, 13.546875 })
    table.insert(muellmarkers, { 2007.671875, -2102.5712890625, 13.546875 })
    table.insert(muellmarkers, { 2070.822265625, -2159.677734375, 13.590328216553 })
    table.insert(muellmarkers, { 1920.388671875, -2125.7587890625, 13.581733703613 })
    table.insert(muellmarkers, { 1874.640625, -2041.75, 13.546875 })
    table.insert(muellmarkers, { 1698.9248046875, -2118.359375, 13.546875 })
    table.insert(muellmarkers, { 1974.80859375, -1884.6376953125, 13.546875 })
    table.insert(muellmarkers, { 2095.291015625, -1827.740234375, 13.5546875 })
    table.insert(muellmarkers, { 2063.9208984375, -1874.142578125, 13.546875 })
    table.insert(muellmarkers, { 2115.1328125, -1905.193359375, 13.546875 })
    table.insert(muellmarkers, { 1882.568359375, -1926.8134765625, 13.546875 })
    table.insert(muellmarkers, { 1914.1123046875, -1806.9541015625, 13.546875 })
    table.insert(muellmarkers, { 1933.7353515625, -1606.279296875, 13.539081573486 })
    table.insert(muellmarkers, { 1990.609375, -1785.6787109375, 13.553680419922 })
    table.insert(muellmarkers, { 2013.6708984375, -1685.0439453125, 13.546875 })
    table.insert(muellmarkers, { 2095.095703125, -1625.828125, 13.55931186676 })
    table.insert(muellmarkers, { 2225.9853515625, -1636.517578125, 15.450145721436 })
    table.insert(muellmarkers, { 2227.7080078125, -1472.599609375, 23.940847396851 })
    table.insert(muellmarkers, { 2326.0205078125, -1477.1533203125, 23.856838226318 })
    table.insert(muellmarkers, { 2222.93359375, -1393.0361328125, 24.000988006592 })
    table.insert(muellmarkers, { 2222.912109375, -1406.748046875, 24 })
    table.insert(muellmarkers, { 2206.3037109375, -1424.8720703125, 23.984375 })
    table.insert(muellmarkers, { 2247.7314453125, -1451.3798828125, 23.828125 })
    table.insert(muellmarkers, { 2253.1259765625, -1416.8701171875, 23.828125 })
    table.insert(muellmarkers, { 2203.3349609375, -1377.2763671875, 24 })
    table.insert(muellmarkers, { 2181.2177734375, -1343.3994140625, 23.984375 })
    table.insert(muellmarkers, { 2146.298828125, -1342.927734375, 23.984375 })
    table.insert(muellmarkers, { 2170.9697265625, -1433.8935546875, 23.984375 })
    table.insert(muellmarkers, { 2262.9794921875, -1292.51171875, 23.98645401001 })
    table.insert(muellmarkers, { 2242.2578125, -1261.4423828125, 23.94585609436 })
    table.insert(muellmarkers, { 2157.3466796875, -1261.2646484375, 23.990283966064 })
    table.insert(muellmarkers, { 2086, -1261.3515625, 23.992172241211 })
    table.insert(muellmarkers, { 2087.537109375, -1314.779296875, 23.984375 })
    table.insert(muellmarkers, { 2094.236328125, -1342.8251953125, 23.984375 })
    table.insert(muellmarkers, { 2137.32421875, -1207.859375, 23.920642852783 })
    table.insert(muellmarkers, { 2269.056640625, -1106.4052734375, 37.9765625 })
    table.insert(muellmarkers, { 2172.4306640625, -1111.8359375, 25.494230270386 })
    table.insert(muellmarkers, { 2034.1015625, -1104.5126953125, 24.59813117981 })
    table.insert(muellmarkers, { 2079.9326171875, -1179.708984375, 23.828052520752 })
    table.insert(muellmarkers, { 2092.6279296875, -1079.1044921875, 25.746276855469 })
    table.insert(muellmarkers, { 2186.3837890625, -1053.6455078125, 51.389442443848 })
    table.insert(muellmarkers, { 2155.8115234375, -997.8173828125, 62.9084815979 })
    table.insert(muellmarkers, { 2010.8134765625, -1034.2939453125, 24.770168304443 })
    table.insert(muellmarkers, { 1951.3916015625, -1056.244140625, 24.277559280396 })
    table.insert(muellmarkers, { 1905.7421875, -1088.021484375, 24.257881164551 })
    table.insert(muellmarkers, { 1870.392578125, -1334.5380859375, 13.553316116333 })
    table.insert(muellmarkers, { 1902.3916015625, -1365.8291015625, 13.536526679993 })
    table.insert(muellmarkers, { 1801.64453125, -1699.2587890625, 13.534524917603 })
    table.insert(muellmarkers, { 1839.333984375, -1829.5380859375, 13.585382461548 })
    table.insert(muellmarkers, { 2367.4150390625, -1653.6982421875, 13.546875 })
    table.insert(muellmarkers, { 2496.2822265625, -2410.4541015625, 13.410018920898 })
    table.insert(muellmarkers, { 2649.8994140625, -2400.466796875, 13.420581817627 })
    table.insert(muellmarkers, { 2594.341796875, -2499.861328125, 13.454496383667 })
    table.insert(muellmarkers, { 2202.591796875, -2489.7734375, 13.335213661194 })
    table.insert(muellmarkers, { 2505.474609375, -2233.0546875, 13.429344177246 })
    table.insert(muellmarkers, { 2659.8837890625, -2000.7265625, 13.265132904053 })
    table.insert(muellmarkers, { 2772.8828125, -1956.5380859375, 13.193690299988 })
    table.insert(muellmarkers, { 2449.21875, -1976.7587890625, 13.431105613708 })
    table.insert(muellmarkers, { 2484.873046875, -2014.556640625, 13.282417297363 })
    table.insert(muellmarkers, { 2348.78515625, -2006.1259765625, 13.426029205322 })
    table.insert(muellmarkers, { 2290.369140625, -1889.880859375, 13.32905292511 })
    table.insert(muellmarkers, { 2269.4072265625, -1753.1005859375, 13.265124320984 })
    table.insert(muellmarkers, { 645, -1544.9000244141, 15.199999809265 })
    table.insert(muellmarkers, { 2670.505859375, -1459.361328125, 30.431535720825 })
    table.insert(muellmarkers, { 2686.2666015625, -1329.6474609375, 43.237724304199 })
    table.insert(muellmarkers, { 2753.2490234375, -1177.1494140625, 69.286506652832 })
    table.insert(muellmarkers, { 2611.8935546875, -1179.869140625, 63.604663848877 })
    table.insert(muellmarkers, { 2550.9775390625, -1218.3173828125, 52.959857940674 })
    table.insert(muellmarkers, { 2505.4794921875, -1231.76953125, 37.670188903809 })
    table.insert(muellmarkers, { 2585.0927734375, -1323.044921875, 40.28141784668 })
    table.insert(muellmarkers, { 2551.2939453125, -1369.5498046875, 31.492044448853 })
    table.insert(muellmarkers, { 2477.9853515625, -1327.06640625, 27.788778305054 })
    table.insert(muellmarkers, { 2447.634765625, -1372.369140625, 23.70813369751 })
    table.insert(muellmarkers, { 2392.6748046875, -1475.283203125, 23.692573547363 })
    table.insert(muellmarkers, { 2335.3154296875, -1366.818359375, 23.902801513672 })
    table.insert(muellmarkers, { 2404.1982421875, -1382.6484375, 24.098770141602 })
    table.insert(muellmarkers, { 2410.744140625, -1303.2236328125, 24.574760437012 })
    table.insert(muellmarkers, { 2375.541015625, -1217.630859375, 27.311960220337 })
    table.insert(muellmarkers, { 2432.3642578125, -1187.466796875, 35.809589385986 })
    table.insert(muellmarkers, { 2643.3681640625, -1189.15234375, 66.621765136719 })
    table.insert(muellmarkers, { 2739.5029296875, -1076.3037109375, 69.365043640137 })
    table.insert(muellmarkers, { 2542.49609375, -971.251953125, 81.943260192871 })
    table.insert(muellmarkers, { 2452.5478515625, -971.205078125, 79.950576782227 })
    table.insert(muellmarkers, { 2359.7861328125, -1040.615234375, 54.038356781006 })
    table.insert(muellmarkers, { 2489.0244140625, -1049.28515625, 67.755645751953 })
    table.insert(muellmarkers, { 2550.4443359375, -1099.05859375, 63.204471588135 })
    table.insert(muellmarkers, { 2422.90234375, -1105.958984375, 41.191425323486 })
    table.insert(muellmarkers, { 1365.5, -1739.6999511719, 13.39999961853 })
    table.insert(muellmarkers, { 1466.1999511719, -1720.0999755859, 13.39999961853 })
    table.insert(muellmarkers, { 1548, -1720.0999755859, 13.39999961853 })
    table.insert(muellmarkers, { 1591.5999755859, -1600.4000244141, 13.39999961853 })
    table.insert(muellmarkers, { 1574.0999755859, -1879.9000244141, 13.39999961853 })
    table.insert(muellmarkers, { 1364.4000244141, -1878.5, 13.39999961853 })
    table.insert(muellmarkers, { 1162, -1839.8000488281, 13.39999961853 })
    table.insert(muellmarkers, { 1069.5, -1883.1999511719, 13.39999961853 })
    table.insert(muellmarkers, { 987.40002441406, -1775.0999755859, 14 })
    table.insert(muellmarkers, { 896.29998779297, -1796.0999755859, 13.5 })
    table.insert(muellmarkers, { 784.90002441406, -1794.3000488281, 12.89999961853 })
    table.insert(muellmarkers, { 852.59997558594, -1833.8000488281, 12.199999809265 })
    table.insert(muellmarkers, { 656.29998779297, -1765.8000488281, 13 })
    table.insert(muellmarkers, { 676.5, -1628.8000488281, 8.6000003814697 })
    table.insert(muellmarkers, { 475.89999389648, -1732.9000244141, 10.6 })
    table.insert(muellmarkers, { 391.29998779297, -1766, 5.3 })
    table.insert(muellmarkers, { 362.79998779297, -2020.8000488281, 7.6999998092651 })
    table.insert(muellmarkers, { 355.70001220703, -1761.8000488281, 5.0999999046326 })
    table.insert(muellmarkers, { 299.5, -1747.4000244141, 4.4000000953674 })
    table.insert(muellmarkers, { 163.80000305176, -1745.8000488281, 4.5999999046326 })
    table.insert(muellmarkers, { 645.29998779297, -1702.5, 14 })
    table.insert(muellmarkers, { 657.5, -1647.1999511719, 14.89999961853 })
    table.insert(muellmarkers, { 511.89999389648, -1654, 18.600000762939 })
    table.insert(muellmarkers, { 298.79998779297, -1692, 33.2 })
    table.insert(muellmarkers, { 393.20001220703, -1600.0999755859, 28.7 })
    table.insert(muellmarkers, { 505.20001220703, -1603.3000488281, 15.89999961853 })
    table.insert(muellmarkers, { 552.40002441406, -1634.5999755859, 17.200000762939 })
    table.insert(muellmarkers, { 571.20001220703, -1572.5999755859, 16 })
    table.insert(muellmarkers, { 471.60000610352, -1573.5999755859, 24.799999237061 })
    table.insert(muellmarkers, { 356.10000610352, -1546.5, 33.200000762939 })
    table.insert(muellmarkers, { 365.5, -1496.9000244141, 32.5 })
    table.insert(muellmarkers, { 482.39999389648, -1417.9000244141, 16.7 })
    table.insert(muellmarkers, { 494.60000610352, -1446.9000244141, 16.2 })
    table.insert(muellmarkers, { 512.59997558594, -1455.5999755859, 15 })
    table.insert(muellmarkers, { 551.40002441406, -1439.3000488281. 15.6 })
    table.insert(muellmarkers, { 616.90002441406, -1458.9000244141, 14.300000190735 })
    table.insert(muellmarkers, { 645, -1544.9000244141, 15.199999809265 })
    table.insert(muellmarkers, { 769.70001220703, -1595, 13.39999961853 })
    table.insert(muellmarkers, { 832.79998779297, -1631.0999755859, 13.3 })
    table.insert(muellmarkers, { 925.79998779297, -1695.5, 13.39999961853 })
    table.insert(muellmarkers, { 930.90002441406, 1500.4, 13.39999961853 })
    table.insert(muellmarkers, { 1042.5, -1482.8000488281, 13.5 })
    table.insert(muellmarkers, { 1046.6999511719, -1547.1999511719, 13.39999961853 })
    table.insert(muellmarkers, { 1087, -1415.3000488281, 13.4 })
    table.insert(muellmarkers, { 1248.4000244141, -1423.0999755859, 13.39999961853 })
    table.insert(muellmarkers, { 1148.4000244141, -1381.4000244141, 13.699999809265 })
    table.insert(muellmarkers, { 931.20001220703, -1228.5999755859, 16.799999237061 })
    table.insert(muellmarkers, { 992.90002441406, -1339.9000244141, 13.199999809265 })
    table.insert(muellmarkers, { 1007.5999755859, -1214.3000488281, 16.799999237061 })
    table.insert(muellmarkers, { 762.20001220703, -1119.1999511719, 24.200000762939 })
    table.insert(muellmarkers, { 969.90002441406, -1108.3000488281, 23.700000762939 })
    table.insert(muellmarkers, { 981.20001220703, -1047.0999755859, 30.299999237061 })
    table.insert(muellmarkers, { 1065.1999511719, -1030.4000244141, 31.89999961853 })
    table.insert(muellmarkers, { 1155.6999511719, -1110.3000488281, 24.3 })
    table.insert(muellmarkers, { 1098.4000244141, -1153.9000244141, 23.4 })
    table.insert(muellmarkers, { 1369, -1153.9000244141, 23.700000762939 })
    table.insert(muellmarkers, { 1336, -1331.4000244141, 13.29999961853 })
    table.insert(muellmarkers, { 1468.6999511719, -1236.3000488281, 13.3 })
    table.insert(muellmarkers, { 1505.4000244141, -1312.3000488281, 14.199999809265 })
    table.insert(muellmarkers, { 1700.3000488281, -1311.8000488281, 13.3 })
    table.insert(muellmarkers, { 1863.6999511719, -1268.0999755859, 13.39999961853 })
    table.insert(muellmarkers, { 1802.4000244141, -1187.6999511719, 23.700000762939 })
    table.insert(muellmarkers, { 1764.6999511719, -1308.5, 13.3 })
    table.insert(muellmarkers, { 1674, -1141.3000488281, 23.799999237061 })
    table.insert(muellmarkers, { 1681.5, -1073.8000488281, 23.799999237061 }) 
    table.insert(muellmarkers, { 1682.3000488281, -1064.3000488281, 23.799999237061 }) 
    table.insert(muellmarkers, { 1814.9000244141, -1039.3000488281, 23.89999961853 })
    table.insert(muellmarkers, { 1829.1999511719, -1084.3000488281, 23.700000762939 })
    table.insert(muellmarkers, { 1828.6999511719, -1097.4000244141, 23.799999237061 })
    table.insert(muellmarkers, { 1829.4000244141, -1113.8000488281, 23.700000762939 })
    table.insert(muellmarkers, { 1828, -1145.4000244141, 23.799999237061 })
    table.insert(muellmarkers, { 1729.5, -1145.3000488281, 23.799999237061 })
    table.insert(muellmarkers, { 1612, -1031.9000244141, 23.799999237061 })
    table.insert(muellmarkers, { 1524.4000244141, -1017, 23.799999237061 })
    table.insert(muellmarkers, { 1470.9000244141, -1058.9000244141, 23.700000762939 })
    table.insert(muellmarkers, { 1465.3000488281, -1172.0999755859, 23.700000762939 })
    table.insert(muellmarkers, { 1444.3000488281, -1230.8000488281, 13.39999961853 })
    table.insert(muellmarkers, { 1378.1999511719, -1017.4000244141, 26.5 })
    table.insert(muellmarkers, { 1405.4000244141, -931.40002441406, 35.099998474121 })
    table.insert(muellmarkers, { 1255, -918.79998779297, 42.700000762939 })
    table.insert(muellmarkers, { 1241.8000488281, -948.70001220703, 42.3 })
    table.insert(muellmarkers, { 1253.9000244141, -978.79998779297, 37.4 })
    table.insert(muellmarkers, { 1249.1999511719, -1048.5999755859, 31.700000762939 })
    table.insert(muellmarkers, { 1273, -1106.6999511719, 25.10000038147 })
    table.insert(muellmarkers, { 1186.1999511719, -1029.4000244141, 31.89999961853 })
    table.insert(muellmarkers, { 1146.8000488281, -915.29998779297, 42.799999237061 })
    table.insert(muellmarkers, { 934.5, -960.59997558594, 38.400001525879 })
    table.insert(muellmarkers, { 911.90002441406, -997.29998779297, 37.900001525879 })
    table.insert(muellmarkers, { 784.29998779297, -1036.1999511719, 24.299999237061 })
    table.insert(muellmarkers, { 789.29998779297, -1097.9000244141, 23.89999961853 })
    table.insert(muellmarkers, { 722.09997558594, -1123.0999755859, 18 })
    table.insert(muellmarkers, { 660, -1123.0999755859, 18.299999237061 })
    table.insert(muellmarkers, { 583.29998779297, -1242.3000488281, 17.799999237061 })
    table.insert(muellmarkers, { 458.5, -1294.8000488281, 15.39999961853 })
    table.insert(muellmarkers, { 449.39999389648, -1334.1999511719, 15.3 })
    table.insert(muellmarkers, { 183.89999389648, -1410.4000244141, 46 })
    table.insert(muellmarkers, { 222.80000305176, -1341.6999511719, 51.7 })
    table.insert(muellmarkers, { 296, -1310, 54.200000762939 })
    table.insert(muellmarkers, { 390.70001220703, -1241.1999511719, 51.799999237061 })
    table.insert(muellmarkers, { 517.70001220703, -1212.1999511719, 44.299999237061 })
    table.insert(muellmarkers, { 530, -1152.3000488281, 56.700000762939 })
    table.insert(muellmarkers, { 389.29998779297, -1153.4000244141, 78.4 })
    table.insert(muellmarkers, { 311.39999389648, -1198.9000244141, 76.199996948242 })
    table.insert(muellmarkers, { 350.89999389648, -1185.8000488281, 76.900001525879 })
    table.insert(muellmarkers, { 256.39999389648, -1255.9000244141, 71.4 })
    table.insert(muellmarkers, { 327.70001220703, -1256.6999511719, 64.300003051758 })
    table.insert(muellmarkers, { 364.5, -1223, 53.799999237061 })
    table.insert(muellmarkers, { 462.29998779297, -1082.1999511719, 81.2 })
    table.insert(muellmarkers, { 578.90002441406, -1048.4000244141, 72.8 })
    table.insert(muellmarkers, { 693.90002441406, -1005.4000244141, 52.300001525879 })
    table.insert(muellmarkers, { 677.59997558594, -1037.4000244141, 50.900001525879 })
    table.insert(muellmarkers, { 643.40002441406, -1087.1999511719, 47.4 })
    table.insert(muellmarkers, { 826.09997558594, -817, 68.900001525879 })
    table.insert(muellmarkers, { 880.59997558594, -864.79998779297, 77.7 })
    table.insert(muellmarkers, { 926, -824.79998779297, 93.199996948242 })
    table.insert(muellmarkers, { 1001.5, -806.5, 98.700003051758 })
    table.insert(muellmarkers, { 919.09997558594, -786.5, 114.4 })
    table.insert(muellmarkers, { 922, -788.5, 114.3 })
    table.insert(muellmarkers, { 895.20001220703, -757.20001220703, 98.199996948242 })
    table.insert(muellmarkers, { 873.90002441406, -747, 95.199996948242 })
    table.insert(muellmarkers, { 947.59997558594, -669.20001220703, 120.80000305176 })
    table.insert(muellmarkers, { 922.90002441406, -654.20001220703, 117 })
    table.insert(muellmarkers, { 929.59997558594, -631.90002441406, 116.19999694824 })
    table.insert(muellmarkers, { 983.5, -648.09997558594, 122.09999847412 })
    table.insert(muellmarkers, { 1075, -624.70001220703, 114.19999694824 })
    table.insert(muellmarkers, { 1152.5999755859, -638.70001220703, 104.19999694824 })
    table.insert(muellmarkers, { 1271.3000488281, -617.09997558594, 103.40000152588 })
    table.insert(muellmarkers, { 1402.5, -577.20001220703, 79 })
    table.insert(muellmarkers, { 1306.1999511719, -697.40002441406, 93.5 })
    table.insert(muellmarkers, { 1065, -767, 106.70000305176 })
    table.insert(muellmarkers, { 1465.4000244141, -717.29998779297, 92.3 })
    table.insert(muellmarkers, { 1464.6999511719, -773.40002441406, 92.5 })
    table.insert(muellmarkers, { 1502.4000244141, -787.5, 79.300001525879 })
    table.insert(muellmarkers, { 1501.1999511719, -835.70001220703, 67.4 })
    table.insert(muellmarkers, { 1444.1999511719, -850.79998779297, 52.2 })
    table.insert(muellmarkers, { 1397.5999755859, -893.59997558594, 38.1 })
    table.insert(muellmarkers, { 1355.9000244141, -923.59997558594, 34.5 })
    table.insert(muellmarkers, { 1524.3000488281, -973.20001220703, 36.799999237061 })
    table.insert(muellmarkers, { 1600.1999511719, -982.40002441406, 38.5 })
    table.insert(muellmarkers, { 1721.8000488281, -976, 37.6 })
    table.insert(muellmarkers, { 1950.6999511719, -1019, 35.5 })
  

end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createMuellTable)

function resizePlayerJobMarkers()
    playerJobMarkers = {}
    playerJobMarkers = table.copy(muellmarkers)
end

function onPlayerEnterTrashMaster_func()
    local big = 0
    local big = table.getSize(playerJobMarkers)
    if (big <= 2) or (not (big)) then
        resizePlayerJobMarkers()
    end
    for theKey, theElement in ipairs(playerJobMarkers) do
        theElement[4] = createMarker(theElement[1], theElement[2], theElement[3] - 0.5, "cylinder", 3.0, 0, 0, 255)
        theElement[5] = createObject(1264, theElement[1], theElement[2], theElement[3])
        theElement[6] = createObject(1264, theElement[1] + 0.72, theElement[2], theElement[3])
        theElement[7] = createObject(1264, theElement[1] + 0.24, theElement[2] - 0.471, theElement[3])
        theElement[8] = createObject(1264, theElement[1] - 0.26, theElement[2] - 0.24, theElement[3] - 0.25)
        theElement[9] = createObject(1264, theElement[1] + 0.17, theElement[2] - 0.181, theElement[3] + 0.5)
        setElementCollisionsEnabled ( theElement[5], false);
        setElementCollisionsEnabled ( theElement[6], false);
        setElementCollisionsEnabled ( theElement[7], false);
        setElementCollisionsEnabled ( theElement[8], false);
        setElementCollisionsEnabled ( theElement[9], false);
        theElement[10] = createBlip(theElement[1], theElement[2], theElement[3], 0, 2, 0, 0, 255, 255, 0, 1200)
    end
    deponieMarker = createMarker(2181.57421875, -1983.2900390625, 12.433829307556, "cylinder", 3.0, 13, 130, 0)
    deponieBlip = createBlip(2181.57421875, -1983.2900390625, 13.433829307556, 0, 2, 13, 130, 0)
    showError(getLocalPlayer(), "Sammle den Müll ein (blaue Checkpoints) und bringe sie dann zur Mülldeponie (grüner Checkpoint)!")
end

addEvent("onPlayerEnterTrashMaster", true)
addEventHandler("onPlayerEnterTrashMaster", getRootElement(), onPlayerEnterTrashMaster_func)

function exitTrashMaster(thePlayer)
    if (thePlayer == getLocalPlayer()) then
        for theKey, theElement in ipairs(playerJobMarkers) do
            if (isElement(theElement[4])) then destroyElement(theElement[4]) end
            if (isElement(theElement[5])) then destroyElement(theElement[5]) end
            if (isElement(theElement[6])) then destroyElement(theElement[6]) end
            if (isElement(theElement[7])) then destroyElement(theElement[7]) end
            if (isElement(theElement[8])) then destroyElement(theElement[8]) end
            if (isElement(theElement[9])) then destroyElement(theElement[9]) end
            if (isElement(theElement[10])) then destroyElement(theElement[10]) end
        end
        if (isElement(deponieBlip)) then destroyElement(deponieBlip) end
        if (isElement(deponieMarker)) then destroyElement(deponieMarker) end
    end
end

addEventHandler("onClientVehicleExit", getRootElement(), exitTrashMaster)

function onPlayerDiedInMuell()
    if (source == getLocalPlayer()) then
        exitTrashMaster(source)
    end
end

addEventHandler("onClientPlayerWasted", getRootElement(), onPlayerDiedInMuell)

function enterTrashMasterCheckpoint(hitPlayer)
    if (hitPlayer == getLocalPlayer()) then
        if (tonumber(getElementData(hitPlayer, "job")) == 3) then
            for theKey, theElement in ipairs(playerJobMarkers) do
                if (theElement[4] == source) then
                    showError(getLocalPlayer(), "Der Müll wird verladen bitte warte einen Moment!")
                    setElementFrozen(getPedOccupiedVehicle(getLocalPlayer()), true)
                    setTimer(unfreezeTrashVehicle, 3000, 1, getPedOccupiedVehicle(getLocalPlayer()))
                    trashPoints = trashPoints + 1
                    outputChatBox(string.format("Du hast bereits %s Müllsäcke gesammelt!", trashPoints))
                    if (isElement(theElement[4])) then destroyElement(theElement[4]) end
                    if (isElement(theElement[5])) then destroyElement(theElement[5]) end
                    if (isElement(theElement[6])) then destroyElement(theElement[6]) end
                    if (isElement(theElement[7])) then destroyElement(theElement[7]) end
                    if (isElement(theElement[8])) then destroyElement(theElement[8]) end
                    if (isElement(theElement[9])) then destroyElement(theElement[9]) end
                    if (isElement(theElement[10])) then destroyElement(theElement[10]) end
                    table.remove(playerJobMarkers, theKey)
                end
            end
            if (source == deponieMarker) then
                triggerServerEvent("giveTrashUp", getLocalPlayer(), trashPoints)
                trashPoints = 0
                local restmarker = 0
                for theKey, theElement in ipairs(playerJobMarkers) do
                    if (isElement(theElement[4])) then
                        restmarker = restmarker + 1
                        if (isElement(theElement[4])) then destroyElement(theElement[4]) end
                        if (isElement(theElement[5])) then destroyElement(theElement[5]) end
                        if (isElement(theElement[6])) then destroyElement(theElement[6]) end
                        if (isElement(theElement[7])) then destroyElement(theElement[7]) end
                        if (isElement(theElement[8])) then destroyElement(theElement[8]) end
                        if (isElement(theElement[9])) then destroyElement(theElement[9]) end
                        if (isElement(theElement[10])) then destroyElement(theElement[10]) end
                    end
                end
                if (restmarker <= 2) then
                    resizePlayerJobMarkers()
                end
                for theKey, theElement in ipairs(playerJobMarkers) do
                    theElement[4] = createMarker(theElement[1], theElement[2], theElement[3] - 0.5, "cylinder", 3.0, 0, 0, 255)
                    theElement[5] = createObject(1264, theElement[1], theElement[2], theElement[3])
                    theElement[6] = createObject(1264, theElement[1] + 0.72, theElement[2], theElement[3])
                    theElement[7] = createObject(1264, theElement[1] + 0.24, theElement[2] - 0.471, theElement[3])
                    theElement[8] = createObject(1264, theElement[1] - 0.26, theElement[2] - 0.24, theElement[3] - 0.25)
                    theElement[9] = createObject(1264, theElement[1] + 0.17, theElement[2] - 0.181, theElement[3] + 0.5)
                    setElementCollisionsEnabled ( theElement[5], false);
                    setElementCollisionsEnabled ( theElement[6], false);
                    setElementCollisionsEnabled ( theElement[7], false);
                    setElementCollisionsEnabled ( theElement[8], false);
                    setElementCollisionsEnabled ( theElement[9], false);
                    theElement[10] = createBlip(theElement[1], theElement[2], theElement[3], 0, 2, 0, 0, 255, 255, 0, 1200)
                end
            end
        end
    end
end

addEventHandler("onClientMarkerHit", getRootElement(), enterTrashMasterCheckpoint)

function unfreezeTrashVehicle(theVehicle)
    setElementFrozen(theVehicle, false)
end
