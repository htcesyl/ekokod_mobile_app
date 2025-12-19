

### Tüketim
  

Önce seçili binaya ait analizörleri çekmeniz, sonra bu analizörlerin tüketim verilerini almanız gerekiyor.

  

**Adım 1: Bina listesini çekin**

  
**Bina faturaları için bina listesindeki `billHistory` alanını kullanabilirsiniz.**

Kullanıcının erişebildiği binaları almak için `/api/building` endpoint'ine istek atın:

  

```

GET /api/building

```

  

Bu istek size kullanıcının erişebildiği tüm binaları döndürür. Response formatı şöyle:

  

```json

{

  "success": true,

  "buildings": [

 {

    "_id": "6924b162f32b0add2260ece0",

    "company_id": "6924acdaf32b0add2260ecd5",

    "name": "Bolu",

    "address": "Bolu",

    "lat": 40.735259,

    "long": 31.612137,

    "floors": 5,

    "contact_persons": [],

    "personel_count": 1000,

    "total_area": 12800,

    "tariff": {

        "originalTariffId": "679ec31342a985dbdb01ce3c",

        "effectiveFrom": "2024-02-05T21:00:00.000Z",

        "currency": "tl",

        "energy_type": "grid_energy",

        "distribution_type": "ag",

        "distribution_system_user": "commercial",

        "price_type": "single_time",

        "term": "monomial",

        "supply_company": "attendant_company",

        "price": {

            "multi_time_price": {

                "t1": 4.464194,

                "t2": 6.464194,

                "t3": 8.464194

            },

            "power_price": 3.908187,

            "overuse_price": 4.512875,

            "single_time_price": null,

            "reactive_power_price": 3.908187,

            "distribution_cost": 0.000001,

            "green_energy_price": null,

            "green_energy_distribution_cost": null,

            "vat_rate": 18,

            "other_taxes_rate": 3.35

        },

        "isDefault": true

    },

    "sector": "Belediye",

    "billCutoffDay": 9,

    "createdAt": "2025-11-24T19:26:26.666Z",

    "updatedAt": "2025-12-14T14:01:28.845Z",

    "__v": 0,

    "user_in_charge": "6924b18ff32b0add2260ece9",

    "billHistory": {

        "2025-12": {

            "monthKey": "2025-12",

            "currentConsumptionIndex": 387470.397,

            "totalActiveKWh": 7590.000299999976,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 475.51539999999886,

            "totalCapacitiveKVarh": 154.54119999999963,

            "energyCost": 29663.140502456004,

            "distributionCost": 0.007590000299999976,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 5339.366656642134,

            "otherTaxesCost": 0,

            "totalCost": 35002.51474909844,

            "inductiveRatio": 0.06265024785308643,

            "capacitiveRatio": 0.020361158615500995,

            "reactivePenaltyApplied": false,

            "startDate": "09-11-2025",

            "endDate": "09-12-2025",

            "activeGeneration": 0,

            "normalConsumption": 7590.000299999976,

            "overuseConsumption": 0,

            "normalConsumptionCost": 29663.140502456004,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 387470.397,

            "activeConsumption": 7590.000299999976,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 17637.871,

            "indConsumption": 475.51539999999886,

            "capIndex": 25918.905,

            "capConsumption": 154.54119999999963,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-12.pdf"

        },

        "2025-11": {

            "monthKey": "2025-11",

            "currentConsumptionIndex": 386869.977,

            "totalActiveKWh": 32408.132700000024,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 2120.6377000000016,

            "totalCapacitiveKVarh": 570.9418,

            "energyCost": 126657.04291241498,

            "distributionCost": 0.03240813270000002,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 22798.27355769858,

            "otherTaxesCost": 0,

            "totalCost": 149455.34887824627,

            "inductiveRatio": 0.06543535598396263,

            "capacitiveRatio": 0.0176172384038652,

            "reactivePenaltyApplied": false,

            "startDate": "09-10-2025",

            "endDate": "09-11-2025",

            "activeGeneration": 0,

            "normalConsumption": 32408.132700000024,

            "overuseConsumption": 0,

            "normalConsumptionCost": 126657.04291241498,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 386869.977,

            "activeConsumption": 32408.132700000024,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 17413.776,

            "indConsumption": 2120.6377000000016,

            "capIndex": 25865.244,

            "capConsumption": 570.9418,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-11.pdf"

        },

        "2025-10": {

            "monthKey": "2025-10",

            "currentConsumptionIndex": 384257.269,

            "totalActiveKWh": 38734.34009999999,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 2579.0368000000008,

            "totalCapacitiveKVarh": 613.5777000000003,

            "energyCost": 151381.04443239863,

            "distributionCost": 0.038734340099999987,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 27248.59497001297,

            "otherTaxesCost": 0,

            "totalCost": 178629.6781367517,

            "inductiveRatio": 0.06658269621585736,

            "capacitiveRatio": 0.01584066485748651,

            "reactivePenaltyApplied": false,

            "startDate": "09-09-2025",

            "endDate": "09-10-2025",

            "activeGeneration": 0,

            "normalConsumption": 38734.34009999999,

            "overuseConsumption": 0,

            "normalConsumptionCost": 151381.04443239863,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 384257.269,

            "activeConsumption": 38734.34009999999,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 16448.424,

            "indConsumption": 2579.0368000000008,

            "capIndex": 25693.906,

            "capConsumption": 613.5777000000003,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-10.pdf"

        },

        "2025-09": {

            "monthKey": "2025-09",

            "currentConsumptionIndex": 381546.987,

            "totalActiveKWh": 46070.87570000001,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 3065.4664009999988,

            "totalCapacitiveKVarh": 572.1970999999969,

            "energyCost": 180053.59748935595,

            "distributionCost": 0.04607087570000001,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 32409.655840841693,

            "otherTaxesCost": 0,

            "totalCost": 212463.29940107334,

            "inductiveRatio": 0.0665380536927801,

            "capacitiveRatio": 0.01241993105852765,

            "reactivePenaltyApplied": false,

            "startDate": "09-08-2025",

            "endDate": "09-09-2025",

            "activeGeneration": 0,

            "normalConsumption": 46070.87570000001,

            "overuseConsumption": 0,

            "normalConsumptionCost": 180053.59748935595,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 381546.987,

            "activeConsumption": 46070.87570000001,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 15415.112,

            "indConsumption": 3065.4664009999988,

            "capIndex": 25482.015,

            "capConsumption": 572.1970999999969,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-09.pdf"

        },

        "2025-08": {

            "monthKey": "2025-08",

            "currentConsumptionIndex": 377904.013,

            "totalActiveKWh": 55526.102199999994,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 3654.881799,

            "totalCapacitiveKVarh": 578.0717000000021,

            "energyCost": 217006.39077871136,

            "distributionCost": 0.05552610219999999,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 39061.160334866436,

            "otherTaxesCost": 0,

            "totalCost": 256067.60663968,

            "inductiveRatio": 0.06582276900754615,

            "capacitiveRatio": 0.010410809999193535,

            "reactivePenaltyApplied": false,

            "startDate": "09-07-2025",

            "endDate": "09-08-2025",

            "activeGeneration": 0,

            "normalConsumption": 55526.102199999994,

            "overuseConsumption": 0,

            "normalConsumptionCost": 217006.39077871136,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 377904.013,

            "activeConsumption": 55526.102199999994,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 14272.92,

            "indConsumption": 3654.881799,

            "capIndex": 25273.791,

            "capConsumption": 578.0717000000021,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-08.pdf"

        },

        "2025-07": {

            "monthKey": "2025-07",

            "currentConsumptionIndex": 372849.57,

            "totalActiveKWh": 58475.10059999999,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 3662.2046999999984,

            "totalCapacitiveKVarh": 525.9721999999992,

            "energyCost": 228531.62798861216,

            "distributionCost": 0.05847510059999999,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 41135.7035634683,

            "otherTaxesCost": 0,

            "totalCost": 269667.39002718107,

            "inductiveRatio": 0.06262844633738003,

            "capacitiveRatio": 0.008994806244078515,

            "reactivePenaltyApplied": false,

            "startDate": "09-06-2025",

            "endDate": "09-07-2025",

            "activeGeneration": 0,

            "normalConsumption": 58475.10059999999,

            "overuseConsumption": 0,

            "normalConsumptionCost": 228531.62798861216,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 372849.57,

            "activeConsumption": 58475.10059999999,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 13055.035,

            "indConsumption": 3662.2046999999984,

            "capIndex": 25031.361,

            "capConsumption": 525.9721999999992,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-07.pdf"

        },

        "2025-06": {

            "monthKey": "2025-06",

            "currentConsumptionIndex": 366424.646,

            "totalActiveKWh": 48976.55789999996,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 3101.491001000001,

            "totalCapacitiveKVarh": 996.9958000000009,

            "energyCost": 191409.54688952715,

            "distributionCost": 0.04897655789999996,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 34453.72725589531,

            "otherTaxesCost": 0,

            "totalCost": 225863.32312198036,

            "inductiveRatio": 0.06332603053347698,

            "capacitiveRatio": 0.020356591862491866,

            "reactivePenaltyApplied": false,

            "startDate": "09-05-2025",

            "endDate": "09-06-2025",

            "activeGeneration": 0,

            "normalConsumption": 48976.55789999996,

            "overuseConsumption": 0,

            "normalConsumptionCost": 191409.54688952715,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 366424.646,

            "activeConsumption": 48976.55789999996,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 11762.521,

            "indConsumption": 3101.491001000001,

            "capIndex": 24844.966,

            "capConsumption": 996.9958000000009,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-06.pdf"

        },

        "2025-05": {

            "monthKey": "2025-05",

            "currentConsumptionIndex": 359753.449,

            "totalActiveKWh": 37561.87750000006,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 2221.014699000001,

            "totalCapacitiveKVarh": 1199.7550999999987,

            "energyCost": 146798.84134109272,

            "distributionCost": 0.037561877500000056,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 26423.79820253464,

            "otherTaxesCost": 0,

            "totalCost": 173222.67710550487,

            "inductiveRatio": 0.05912949103782146,

            "capacitiveRatio": 0.03194076494179496,

            "reactivePenaltyApplied": false,

            "startDate": "09-04-2025",

            "endDate": "09-05-2025",

            "activeGeneration": 0,

            "normalConsumption": 37561.87750000006,

            "overuseConsumption": 0,

            "normalConsumptionCost": 146798.84134109272,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 359753.449,

            "activeConsumption": 37561.87750000006,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 11488.299,

            "indConsumption": 2221.014699000001,

            "capIndex": 24217.625,

            "capConsumption": 1199.7550999999987,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-05.pdf"

        },

        "2025-04": {

            "monthKey": "2025-04",

            "currentConsumptionIndex": 353123.571,

            "totalActiveKWh": 28960.63619999995,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 1707.6897999999971,

            "totalCapacitiveKVarh": 1046.910200000002,

            "energyCost": 113183.5819085692,

            "distributionCost": 0.02896063619999995,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 20373.049956456973,

            "otherTaxesCost": 0,

            "totalCost": 133556.66082566237,

            "inductiveRatio": 0.058965893850080546,

            "capacitiveRatio": 0.03614941994955221,

            "reactivePenaltyApplied": false,

            "startDate": "09-03-2025",

            "endDate": "09-04-2025",

            "activeGeneration": 0,

            "normalConsumption": 28960.63619999995,

            "overuseConsumption": 0,

            "normalConsumptionCost": 113183.5819085692,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 353123.571,

            "activeConsumption": 28960.63619999995,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 11231.909,

            "indConsumption": 1707.6897999999971,

            "capIndex": 23395.31,

            "capConsumption": 1046.910200000002,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-04.pdf"

        },

        "2025-03": {

            "monthKey": "2025-03",

            "currentConsumptionIndex": 347187.798,

            "totalActiveKWh": 31753.636000000035,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 1736.0602000000017,

            "totalCapacitiveKVarh": 1281.2755000000016,

            "energyCost": 124099.14741793214,

            "distributionCost": 0.031753636000000036,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 22337.852250882264,

            "otherTaxesCost": 0,

            "totalCost": 146437.03142245038,

            "inductiveRatio": 0.05467280030545163,

            "capacitiveRatio": 0.040350512930235775,

            "reactivePenaltyApplied": false,

            "startDate": "09-02-2025",

            "endDate": "09-03-2025",

            "activeGeneration": 0,

            "normalConsumption": 31753.636000000035,

            "overuseConsumption": 0,

            "normalConsumptionCost": 124099.14741793214,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 347187.798,

            "activeConsumption": 31753.636000000035,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 10941.839,

            "indConsumption": 1736.0602000000017,

            "capIndex": 22665.104,

            "capConsumption": 1281.2755000000016,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-03.pdf"

        },

        "2025-02": {

            "monthKey": "2025-02",

            "currentConsumptionIndex": 341804.64,

            "totalActiveKWh": 28380.99880000001,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 1671.9652999999987,

            "totalCapacitiveKVarh": 1158.3974999999996,

            "energyCost": 110918.25055717563,

            "distributionCost": 0.028380998800000008,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 19965.290208871396,

            "otherTaxesCost": 0,

            "totalCost": 130883.56914704584,

            "inductiveRatio": 0.05891143267304596,

            "capacitiveRatio": 0.04081595253793532,

            "reactivePenaltyApplied": false,

            "startDate": "09-01-2025",

            "endDate": "09-02-2025",

            "activeGeneration": 0,

            "normalConsumption": 28380.99880000001,

            "overuseConsumption": 0,

            "normalConsumptionCost": 110918.25055717563,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 341804.64,

            "activeConsumption": 28380.99880000001,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 10818.727,

            "indConsumption": 1671.9652999999987,

            "capIndex": 21767.155,

            "capConsumption": 1158.3974999999996,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-02.pdf"

        },

        "2025-01": {

            "monthKey": "2025-01",

            "currentConsumptionIndex": 897971.061,

            "totalActiveKWh": 26291.697399999935,

            "t1KWh": 0,

            "t2KWh": 0,

            "t3KWh": 0,

            "totalInductiveKVarh": 1374.3024000000003,

            "totalCapacitiveKVarh": 863.9701999999962,

            "energyCost": 102752.86998661354,

            "distributionCost": 0.026291697399999935,

            "capacityCost": 0,

            "greenEnergyCost": 0,

            "reactivePenalty": 0,

            "vatCost": 18495.52133009597,

            "otherTaxesCost": 0,

            "totalCost": 121248.41760840692,

            "inductiveRatio": 0.05227134555412933,

            "capacitiveRatio": 0.032860951761904816,

            "reactivePenaltyApplied": false,

            "startDate": "09-12-2024",

            "endDate": "09-01-2025",

            "activeGeneration": 0,

            "normalConsumption": 26291.697399999935,

            "overuseConsumption": 0,

            "normalConsumptionCost": 102752.86998661354,

            "overuseConsumptionCost": 0,

            "normalPrice": 3.908187,

            "overusePrice": 0,

            "isTwoPartCalculation": false,

            "activeIndex": 897971.061,

            "activeConsumption": 26291.697399999935,

            "t1Index": 0,

            "t1Consumption": 0,

            "t2Index": 0,

            "t2Consumption": 0,

            "t3Index": 0,

            "t3Consumption": 0,

            "indIndex": 241117.395,

            "indConsumption": 1374.3024000000003,

            "capIndex": 20923.011,

            "capConsumption": 863.9701999999962,

            "activeGenerationIndex": 0,

            "analyzerIds": [

                "693743f6267022a0ec4abc71",

                "69374402267022a0ec4abc74",

                "6937440b267022a0ec4abc77",

                "69374416267022a0ec4abc7a",

                "6937441b267022a0ec4abc7d",

                "69374420267022a0ec4abc80",

                "6937442b267022a0ec4abc83",

                "69374436267022a0ec4abc86",

                "69374440267022a0ec4abc8c",

                "69374448267022a0ec4abc8f",

                "69374456267022a0ec4abc92",

                "6937445f267022a0ec4abc95",

                "69374465267022a0ec4abc98",

                "6937446b267022a0ec4abc9b",

                "69374474267022a0ec4abc9e",

                "6937447f267022a0ec4abca1",

                "69374488267022a0ec4abca4",

                "6937448f267022a0ec4abca7",

                "6937449d267022a0ec4abcaa",

                "693744a8267022a0ec4abcb0",

                "693744b2267022a0ec4abcb3",

                "693744bc267022a0ec4abcb6",

                "693744c5267022a0ec4abcb9",

                "693744cd267022a0ec4abcbc",

                "693744d4267022a0ec4abcc2",

                "693744da267022a0ec4abcc5",

                "693744e1267022a0ec4abcc8"

            ],

            "pdfPath": "/opt/bills/Bolu_Belediyesi/buildings/Bolu/fatura-2025-01.pdf"

        }

    }

}

  ]

}

```

  

Kullanıcı bir bina seçtiğinde, `_id` değerini saklayın.

  

**Adım 2: Seçili binaya ait analizörleri çekin**

  
**Analizör faturaları için analizör listesindeki `billHistory` alanını kullanabilirsiniz**.
Seçili binanın ID'si ile `/api/analyzer` endpoint'ine istek atın:

  

```

GET /api/analyzer?buildingId=507f1f77bcf86cd799439011&excludeEnergyValues=true&excludeHourlyValues=true

```

  

Response formatı:

  

```json

{

  "success": true,

  "analyzers": [

 {
    "_id": "693744e1267022a0ec4abcc8",
    "building": "6924b162f32b0add2260ece0",
    "subIntegration": "Sedas",
    "installationNumber": "86905",
    "customerName": "BOLU BELEDİYE BAŞKANLIĞI",
    "address": "MERKEZ ÇAYIRKÖY  KÖPRÜCÜLER YOLU 1 14",
    "il": "",
    "ilce": "",
    "koyMahallesi": "",
    "caddesiSokagi": "",
    "tarifeTipi": "",
    "tarifeTuru": "",
    "tesisatTurTanim": "",
    "kuruluGucu": "8.35",
    "koordinatX": "",
    "koordinatY": "",
    "meterNumber": "52728638",
    "meterModel": "MSY",
    "meterMultiplier": "1",
    "muhatapNo": "",
    "sayimNokTanim": "",
    "lastLoadProfileDate": "20251208230000",
    "lastEndexDate": "20251209002516",
    "definitionType": 2,
    "lastDataDate": "2025-12-08T00:00:00.000Z",
    "isActive": true,
    "createdAt": "2025-12-08T21:36:39.955Z",
    "updatedAt": "2025-12-14T13:40:14.113Z",
    "__v": 0,
    "billHistory": {
        "2025-12": {
            "monthKey": "2025-12",
            "currentConsumptionIndex": 47810.987,
            "totalActiveKWh": 79.207,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 7.755,
            "totalCapacitiveKVarh": 14.397,
            "energyCost": 309.556,
            "distributionCost": 0,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 57.587,
            "otherTaxesCost": 10.37,
            "totalCost": 377.513,
            "inductiveRatio": 0.098,
            "capacitiveRatio": 0.182,
            "reactivePenaltyApplied": false,
            "startDate": "09-11-2025",
            "endDate": "09-12-2025",
            "activeGeneration": 0,
            "normalConsumption": 79.207,
            "overuseConsumption": 0,
            "normalConsumptionCost": 309.556,
            "overuseConsumptionCost": 0,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": false,
            "activeIndex": 47810.987,
            "activeConsumption": 79.207,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 4453.274,
            "indConsumption": 7.755,
            "capIndex": 1982.582,
            "capConsumption": 14.397,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-12.pdf"
        },
        "2025-11": {
            "monthKey": "2025-11",
            "currentConsumptionIndex": 47731.78,
            "totalActiveKWh": 2832.684,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 202.753,
            "totalCapacitiveKVarh": 46.333,
            "energyCost": 12203.048,
            "distributionCost": 0.003,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 2270.133,
            "otherTaxesCost": 408.802,
            "totalCost": 14881.986,
            "inductiveRatio": 0.072,
            "capacitiveRatio": 0.016,
            "reactivePenaltyApplied": false,
            "startDate": "09-10-2025",
            "endDate": "09-11-2025",
            "activeGeneration": 0,
            "normalConsumption": 960,
            "overuseConsumption": 1872.684,
            "normalConsumptionCost": 3751.86,
            "overuseConsumptionCost": 8451.189,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 47731.78,
            "activeConsumption": 2832.684,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 4445.519,
            "indConsumption": 202.753,
            "capIndex": 1968.185,
            "capConsumption": 46.333,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-11.pdf"
        },
        "2025-10": {
            "monthKey": "2025-10",
            "currentConsumptionIndex": 44899.096,
            "totalActiveKWh": 4068.247,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 304.663,
            "totalCapacitiveKVarh": 26.253,
            "energyCost": 17797.13,
            "distributionCost": 0.004,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 3310.8,
            "otherTaxesCost": 596.204,
            "totalCost": 21704.138,
            "inductiveRatio": 0.075,
            "capacitiveRatio": 0.006,
            "reactivePenaltyApplied": false,
            "startDate": "09-09-2025",
            "endDate": "09-10-2025",
            "activeGeneration": 0,
            "normalConsumption": 930,
            "overuseConsumption": 3138.247,
            "normalConsumptionCost": 3634.614,
            "overuseConsumptionCost": 14162.516,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 44899.096,
            "activeConsumption": 4068.247,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 4242.766,
            "indConsumption": 304.663,
            "capIndex": 1921.852,
            "capConsumption": 26.253,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-10.pdf"
        },
        "2025-09": {
            "monthKey": "2025-09",
            "currentConsumptionIndex": 40830.849,
            "totalActiveKWh": 3814.679,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 333.026,
            "totalCapacitiveKVarh": 13.935,
            "energyCost": 16634.669,
            "distributionCost": 0.004,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 3094.547,
            "otherTaxesCost": 557.261,
            "totalCost": 20286.482,
            "inductiveRatio": 0.087,
            "capacitiveRatio": 0.004,
            "reactivePenaltyApplied": false,
            "startDate": "09-08-2025",
            "endDate": "09-09-2025",
            "activeGeneration": 0,
            "normalConsumption": 960,
            "overuseConsumption": 2854.679,
            "normalConsumptionCost": 3751.86,
            "overuseConsumptionCost": 12882.809,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 40830.849,
            "activeConsumption": 3814.679,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 3938.103,
            "indConsumption": 333.026,
            "capIndex": 1895.599,
            "capConsumption": 13.935,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-09.pdf"
        },
        "2025-08": {
            "monthKey": "2025-08",
            "currentConsumptionIndex": 37016.17,
            "totalActiveKWh": 3532.342,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 362.651,
            "totalCapacitiveKVarh": 14.257,
            "energyCost": 15360.517,
            "distributionCost": 0.004,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 2857.517,
            "otherTaxesCost": 514.577,
            "totalCost": 18732.615,
            "inductiveRatio": 0.103,
            "capacitiveRatio": 0.004,
            "reactivePenaltyApplied": false,
            "startDate": "09-07-2025",
            "endDate": "09-08-2025",
            "activeGeneration": 0,
            "normalConsumption": 960,
            "overuseConsumption": 2572.342,
            "normalConsumptionCost": 3751.86,
            "overuseConsumptionCost": 11608.658,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 37016.17,
            "activeConsumption": 3532.342,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 3605.077,
            "indConsumption": 362.651,
            "capIndex": 1881.664,
            "capConsumption": 14.257,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-08.pdf"
        },
        "2025-07": {
            "monthKey": "2025-07",
            "currentConsumptionIndex": 33483.828,
            "totalActiveKWh": 3683.716,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 378.337,
            "totalCapacitiveKVarh": 12.997,
            "energyCost": 16061.79,
            "distributionCost": 0.004,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 2987.975,
            "otherTaxesCost": 538.07,
            "totalCost": 19587.838,
            "inductiveRatio": 0.103,
            "capacitiveRatio": 0.004,
            "reactivePenaltyApplied": false,
            "startDate": "09-06-2025",
            "endDate": "09-07-2025",
            "activeGeneration": 0,
            "normalConsumption": 930,
            "overuseConsumption": 2753.716,
            "normalConsumptionCost": 3634.614,
            "overuseConsumptionCost": 12427.176,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 33483.828,
            "activeConsumption": 3683.716,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 3242.426,
            "indConsumption": 378.337,
            "capIndex": 1867.407,
            "capConsumption": 12.997,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-07.pdf"
        },
        "2025-06": {
            "monthKey": "2025-06",
            "currentConsumptionIndex": 29800.112,
            "totalActiveKWh": 3009.29,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 314.404,
            "totalCapacitiveKVarh": 18.411,
            "energyCost": 13000.049,
            "distributionCost": 0.003,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 2418.399,
            "otherTaxesCost": 435.502,
            "totalCost": 15853.953,
            "inductiveRatio": 0.104,
            "capacitiveRatio": 0.006,
            "reactivePenaltyApplied": false,
            "startDate": "09-05-2025",
            "endDate": "09-06-2025",
            "activeGeneration": 0,
            "normalConsumption": 960,
            "overuseConsumption": 2049.29,
            "normalConsumptionCost": 3751.86,
            "overuseConsumptionCost": 9248.19,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 29800.112,
            "activeConsumption": 3009.29,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 2864.089,
            "indConsumption": 314.404,
            "capIndex": 1854.41,
            "capConsumption": 18.411,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-06.pdf"
        },
        "2025-05": {
            "monthKey": "2025-05",
            "currentConsumptionIndex": 26790.822,
            "totalActiveKWh": 4434.293,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 404.651,
            "totalCapacitiveKVarh": 4.748,
            "energyCost": 19449.05,
            "distributionCost": 0.004,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 3618.107,
            "otherTaxesCost": 651.543,
            "totalCost": 23718.705,
            "inductiveRatio": 0.091,
            "capacitiveRatio": 0.001,
            "reactivePenaltyApplied": false,
            "startDate": "09-04-2025",
            "endDate": "09-05-2025",
            "activeGeneration": 0,
            "normalConsumption": 930,
            "overuseConsumption": 3504.293,
            "normalConsumptionCost": 3634.614,
            "overuseConsumptionCost": 15814.436,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 26790.822,
            "activeConsumption": 4434.293,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 2549.685,
            "indConsumption": 404.651,
            "capIndex": 1835.999,
            "capConsumption": 4.748,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-05.pdf"
        },
        "2025-04": {
            "monthKey": "2025-04",
            "currentConsumptionIndex": 22356.529,
            "totalActiveKWh": 1759.306,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 141.653,
            "totalCapacitiveKVarh": 3.723,
            "energyCost": 7359.028,
            "distributionCost": 0.002,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 1369,
            "otherTaxesCost": 246.527,
            "totalCost": 8974.557,
            "inductiveRatio": 0.081,
            "capacitiveRatio": 0.002,
            "reactivePenaltyApplied": false,
            "startDate": "09-03-2025",
            "endDate": "09-04-2025",
            "activeGeneration": 0,
            "normalConsumption": 960,
            "overuseConsumption": 799.306,
            "normalConsumptionCost": 3751.86,
            "overuseConsumptionCost": 3607.168,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": true,
            "activeIndex": 22356.529,
            "activeConsumption": 1759.306,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 2145.034,
            "indConsumption": 141.653,
            "capIndex": 1831.251,
            "capConsumption": 3.723,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-04.pdf"
        },
        "2025-03": {
            "monthKey": "2025-03",
            "currentConsumptionIndex": 20597.223,
            "totalActiveKWh": 0,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 0,
            "totalCapacitiveKVarh": 0,
            "energyCost": 0,
            "distributionCost": 0,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 0,
            "otherTaxesCost": 0,
            "totalCost": 0,
            "inductiveRatio": 0,
            "capacitiveRatio": 0,
            "reactivePenaltyApplied": false,
            "startDate": "09-02-2025",
            "endDate": "09-03-2025",
            "activeGeneration": 0,
            "normalConsumption": 0,
            "overuseConsumption": 0,
            "normalConsumptionCost": 0,
            "overuseConsumptionCost": 0,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": false,
            "activeIndex": 20597.223,
            "activeConsumption": 0,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 2003.381,
            "indConsumption": 0,
            "capIndex": 1827.528,
            "capConsumption": 0,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-03.pdf"
        },
        "2025-02": {
            "monthKey": "2025-02",
            "currentConsumptionIndex": 20597.223,
            "totalActiveKWh": 0,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 0,
            "totalCapacitiveKVarh": 0,
            "energyCost": 0,
            "distributionCost": 0,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 0,
            "otherTaxesCost": 0,
            "totalCost": 0,
            "inductiveRatio": 0,
            "capacitiveRatio": 0,
            "reactivePenaltyApplied": false,
            "startDate": "09-01-2025",
            "endDate": "09-02-2025",
            "activeGeneration": 0,
            "normalConsumption": 0,
            "overuseConsumption": 0,
            "normalConsumptionCost": 0,
            "overuseConsumptionCost": 0,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": false,
            "activeIndex": 20597.223,
            "activeConsumption": 0,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 2003.381,
            "indConsumption": 0,
            "capIndex": 1827.528,
            "capConsumption": 0,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-02.pdf"
        },
        "2025-01": {
            "monthKey": "2025-01",
            "currentConsumptionIndex": 20597.223,
            "totalActiveKWh": 0,
            "t1KWh": 0,
            "t2KWh": 0,
            "t3KWh": 0,
            "totalInductiveKVarh": 0,
            "totalCapacitiveKVarh": 0,
            "energyCost": 0,
            "distributionCost": 0,
            "capacityCost": 0,
            "greenEnergyCost": 0,
            "reactivePenalty": 0,
            "vatCost": 0,
            "otherTaxesCost": 0,
            "totalCost": 0,
            "inductiveRatio": 0,
            "capacitiveRatio": 0,
            "reactivePenaltyApplied": false,
            "startDate": "09-12-2024",
            "endDate": "09-01-2025",
            "activeGeneration": 0,
            "normalConsumption": 0,
            "overuseConsumption": 0,
            "normalConsumptionCost": 0,
            "overuseConsumptionCost": 0,
            "normalPrice": 3.908187,
            "overusePrice": 4.512875,
            "isTwoPartCalculation": false,
            "activeIndex": 20597.223,
            "activeConsumption": 0,
            "t1Index": 0,
            "t1Consumption": 0,
            "t2Index": 0,
            "t2Consumption": 0,
            "t3Index": 0,
            "t3Consumption": 0,
            "indIndex": 2003.381,
            "indConsumption": 0,
            "capIndex": 1827.528,
            "capConsumption": 0,
            "activeGenerationIndex": 0,
            "pdfPath": "/opt/bills/Bolu_Belediyesi/analyzers/86905/fatura-2025-01.pdf"
        }
    }
}

  ]

}

```


  

**Adım 3: Tüketim verilerini çekin**

  

Analizör ID'leri ile `/api/consumption` endpoint'ine istek atın. (Pagination ve filtreleme için page limit start_date end_date değerleri kullanılabilir, period daily monthly yearly olabilir):

  

```

GET /api/consumption?analyzer_id=693744c5267022a0ec4abcb9&period=daily&start_date=2025-06-14&end_date=2025-12-14&page=1&limit=1000

```

  

Birden fazla analizör için (virgülle ayırarak):

  

```

GET /api/consumption?analyzer_ids=507f1f77bcf86cd799439013,507f1f77bcf86cd799439014&period=monthly

```

  

Response formatı:

  

```json

{

  "consumption": [

{
    "periodLabel": "01/07/2025",
    "activeIndex": 29948.525,
    "indIndex": 2877.876,
    "capIndex": 1854.465,
    "t1Index": 0,
    "t2Index": 0,
    "t3Index": 0,
    "activeGenerationIndex": 0,
    "indGenerationIndex": 0,
    "capGenerationIndex": 0,
    "u1Index": 0,
    "u2Index": 0,
    "u3Index": 0,
    "activeConsumption": 148.41300000000047,
    "indConsumption": 13.787000000000262,
    "capConsumption": 0.05499999999983629,
    "indRate": 0.09289617486338946,
    "capRate": 0.0003705874822275415,
    "t1Consumption": 0,
    "t2Consumption": 0,
    "t3Consumption": 0,
    "activeGeneration": 0,
    "indGeneration": 0,
    "capGeneration": 0,
    "u1Generation": 0,
    "u2Generation": 0,
    "u3Generation": 0
}

  ],

  "pagination": {

    "total": 31,

    "page": 1,

    "totalPages": 1

  }

}

```

  

**Adım 4: Verilerin kullanımı**

- **Dönemin Tüketimi:** `activeConsumption` değeri istek atılan perioda göre period labelda tarihindeki tüketimi belirtir. Örneğin `daily` perioduyla istek atılırsa `01/10/2025` şeklinde periodLabel gelir ve o objenin active consumption alanı 01/10/2025 gününün tüketimini belirtir. `monthly` perioduyla istek atılırsa periodLabel alanı 10/2025 olarak gelir o objenin active consumption alanı 10/2025 ayının o analizör için toplam tüketimini belirler. (kWh/Gün formatında)

- **Dönem Üretimi:** `activeGeneration` alanı aynı mantıkta.

  

Eğer birden fazla analizör için toplam almak istiyorsanız, `analyzer_ids` parametresini kullanın. Bu durumda response formatı biraz farklı olur:

  

```json

{

  "consumptions": {

    "507f1f77bcf86cd799439013": [

      {

        "periodLabel": "01/10/2025",

        "activeConsumption": 32.40
        
        ...

      }

    ],

    "507f1f77bcf86cd799439014": [

      {

        "periodLabel": "01/10/2025",

        "activeConsumption": 25.60
        
        ...

      }

    ]

  }

}

```

  



---

  

### 3. Reaktif Ceza Durumu

  

Reaktif ceza durumunu göstermek için aylık tüketim verilerini ve analizör bilgilerini kullanmanız gerekiyor.


Aşağıdaki formülü kullanarak reaktif oranları hesaplayın:

  

```javascript

// Reaktif oranları hesapla

const inductiveRatio = (indConsumption / activeConsumption) * 100; // %

const capacitiveRatio = (capConsumption / activeConsumption) * 100; // %

  

// Eşik değerleri (kurulu güce göre)

let inductiveThreshold = 33; // %

let capacitiveThreshold = 20; // %

  

// Kurulu güç >= 30 kW ise eşik değerleri değişir

const kuruluGuc = parseFloat(analyzer.kuruluGucu || "0");

if (kuruluGuc >= 30) {

  inductiveThreshold = 20; // %

  capacitiveThreshold = 15; // %

}

```

  

**Adım 4: Sonuçları gösterin**

  

Hesaplanan oranları yüzde formatında gösterin. Örnek:

  

- **Kapasitif:** `%0.58` (3.92 / 1600.00 * 100)

- **Endüktif:** `%2.45` (9.28 / 1600.00 * 100)

  

Eğer oranlar eşik değerlerini aşıyorsa, reaktif ceza uygulanıyor demektir.
  
