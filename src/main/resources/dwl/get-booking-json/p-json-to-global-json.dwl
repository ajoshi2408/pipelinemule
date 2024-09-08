%dw 2.0
output application/json
---
{
	number: payload.number,
	headers: {
		"label": payload.headers.label default "",
		"senderID": payload.headers.senderID default "",
		"receiverID": payload.headers.receiverID default "",
		"shipmentIdNumber": payload.headers.shipmentIdNumber default "",
		"readyDate": payload.headers.readyDate default "",
		"paymentTerms": payload.headers.paymentTerms default "",
		"status": payload.headers.status default "",
		"source": payload.headers.source default "",
		"sourceDescription" : payload.headers.sourceDescription default "",
		"cargo807Ind": payload.headers.cargo807Ind default "",
		"hazLockDate": payload.headers.hazLockDate default "",
		"hazLockTime": payload.headers.hazLockTime default "",
		"bookDate": payload.headers.bookDate replace "-" with "" default "",
		"inbondInd": payload.headers.inbondInd default "",
		"inbondType": payload.headers.inbondType default "",
		"bookTypeCode": payload.headers.bookTypeCode default "",
		licenseReqInd: payload.headers.licenseReqInd default "",
		usFlagInd: payload.headers.usFlagInd default "",
		bolReleaseLoc: payload.headers.bolReleaseLoc default "",
		noSplitInd: payload.headers.noSplitInd default "",
		noAdvanceInd: payload.headers.noAdvanceInd default "",
		loadLastInd: payload.headers.loadLastInd default "",
		insureReqInd: payload.headers.insureReqInd default "",
		origCmcPickupDelvr: payload.headers.origCmcPickupDelvr default "",
		destCmcPickupDelvr: payload.headers.destCmcPickupDelvr default "",
		cmcPickupLoc: payload.headers.cmcPickupLoc default "",
		cmcDeliverLoc: payload.headers.cmcDeliverLoc default "",
		originAltPort: payload.headers.originAltPort default "",
		destAltPort: payload.headers.destAltPort default "",
		bkgBolNum: payload.headers.bkgBolNum default "",
		bkgReqActionCode: payload.headers.bkgReqActionCode default "",
		bkgReqSCAC: payload.headers.bkgReqSCAC default ""
	},
	optionalServices: payload.optionalServices default [] map ((optionalServicesItem, index) -> 
    {
		optionalService : {
			"type" : optionalServicesItem.optionalService.'type' default "",
			selected: optionalServicesItem.optionalService.selected default "",
			charge: optionalServicesItem.optionalService.charge default "",
			count: optionalServicesItem.optionalService.count default "",
			freightId: optionalServicesItem.optionalService.freightId default ""
		}
	}),
	serviceType: {
		originType: payload.serviceType.originType default "",
		destinationType: payload.serviceType.destinationType default "",
		description: payload.serviceType.description default ""
	},
	imType: {
		imOrigin: payload.imType.imOrigin default "",
		imDestination: payload.imType.imDestination default ""
	},
	tmsType: {
		tmsOrigin: payload.tmsType.tmsOrigin default "",
		tmsDestination: payload.tmsType.tmsDestination default ""
	},
	customerOrigin : {
		transId: payload.customerOrigin.transId default "",
		stopId: payload.customerOrigin.stopId default "",
		code: payload.customerOrigin.code default "",
		city: payload.customerOrigin.city default "",
		state: payload.customerOrigin.state default "",
		country: payload.customerOrigin.country default "",
		zip: payload.customerOrigin.zip default "",
		referenceNumber: payload.customerOrigin.referenceNumber default ""
	},
	customerDestination : {
		transId: payload.customerDestination.transId default "",
		stopId: payload.customerDestination.stopId default "",
		code: payload.customerDestination.code default "",
		city: payload.customerDestination.city default "",
		state: payload.customerDestination.state default "",
		country: payload.customerDestination.country default "",
		zip: payload.customerDestination.zip default "",
		referenceNumber: payload.customerDestination.referenceNumber default ""
	},
	connectingCarrier: {
		connectWith: payload.connectingCarrier.connectWith default "",
		connectAtLoc: {
			city: payload.connectingCarrier.connectAtLoc.city default "",
			state: payload.connectingCarrier.connectAtLoc.state default "",
			country: payload.connectingCarrier.connectAtLoc.country default ""
		},
		connectToLoc: {
			city: payload.connectingCarrier.connectToLoc.city default "",
			state: payload.connectingCarrier.connectToLoc.state default "",
			country: payload.connectingCarrier.connectToLoc.country default ""
		}
	},
	parties: payload.parties default [] filter (!isEmpty($.id))  map ((party) -> {
		id: party.id default "",
		"type": party.'type' default "",
		cvif: party.cvif default "",
		cvifLocationCode: party.cvifLocationCode default "",
		custLocationType: party.custLocationType default "",
		custLocation: party.custLocation default "",
		refNumber: party.refNumber default "",
		chbNumber: party.chbNumber default "",
		partyName: party.partyName default "",
		billToInd: party.billToInd default "",
		bookbyInd: party.bookbyInd default "",
		notifyInd: party.notifyInd default "",
		contactName: party.contactName default "",
		phoneNumber: party.phoneNumber default "",
		emailAddr: party.emailAddr default "",
		faxNumber: party.faxNumber default "",
		location: {
			addressLine1: party.location.addressLine1 default "",
			addressLine2: party.location.addressLine2 default "",
			city: party.location.city default "",
			state: party.location.state default "",
			country: party.location.country default "",
			zip: party.location.zip default ""
		}
	}) ,
	transports: payload.transports default [] filter (!isEmpty($.id)) map 
			((transport) -> ({
		id: transport.id default "",
		originDestCd: transport.originDestCd default "",
		ctlLocAbbr: transport.ctlLocAbbr default "",
		carrierCode: transport.carrierCode default "",
		quoteNbr: transport.quoteNbr default "",
		ssupInd: transport.ssupInd default "",
		transportInstructions: transport.transportInstructions default [],
		stops: transport.stops default [] filter (!isEmpty($.stopId)) map
			((stop, indexOfStop) -> {
			stopId: stop.stopId default "",
			cvif: stop.cvif default "",
			cvifLocationCode: stop.cvifLocationCode default "",
			unLoc: stop.unLoc default "",
			custLocationType: stop.custLocationType default "",
			custLocation: stop.custLocation default "",
			stopName: stop.stopName default "",
			name: stop.name default "",
			phoneNumber: stop.phoneNumber default "",
			dropPullInd: stop.dropPullInd default "",
			liveLoadInd: stop.liveLoadInd default "",
			stopRefNumber: stop.stopRefNumber default "",
			pickupDate: stop.pickupDate replace "-" with "" default "",
			pickupTimeFrom: stop.pickupTimeFrom default "",
			pickupTimeTo: stop.pickupTimeTo default "",
			pickupTimeZoneTo: stop.pickupTimeZoneTo default "",
			dropDate: stop.dropDate replace "-" with "" default "",
			dropTimeFrom: stop.dropTimeFrom default "",
			dropTimeTo: stop.dropTimeTo default "",
			dropTimeZoneTo: stop.dropTimeZoneTo default "",
			callDateInd: stop.callDateInd default "",
			callTimeInd: stop.callTimeInd default "",
			addressId: stop.addressId default "",
			address1: stop.address1 default "",
			address2: stop.address2 default "",
			city: stop.city default "",
			state: stop.state default "",
			zip: stop.zip default "",
			country: stop.country default ""
		} )
	})	 ),
	bookingRemarks: payload.bookingRemarks default []  map 
		((bookingRemark) -> {
		bookingRemark: {
			source: bookingRemark.bookingRemark.source default "",
			key: bookingRemark.bookingRemark.key default "",
			lineNum: bookingRemark.bookingRemark.lineNum default "",
			remark: bookingRemark.bookingRemark.remark default "",
			timestamp: bookingRemark.bookingRemark.timestamp default "",
			empNumber: bookingRemark.bookingRemark.empNumber default "",
			hdrFtr: ""
		}
	}),
	bookingReferenceNums: [],
	ediReferenceNums: payload.ediReferenceNums default [] map ((value,indexOfValue)->{
		ediReferenceNum: {
			qualifier: value.ediReferenceNum.qualifier,
			referenceNumber: value.ediReferenceNum.referenceNumber
		}
	}),
	shipments: (payload.shipments default [] filter (!isEmpty($.number))   map
	  (
            (shipment) ->   
            {
		number: shipment.number default "",
		origin: {
			port: shipment.origin.port default "",
			location : {
				locCode: shipment.origin.location.locCode default "",
				city: shipment.origin.location.city default "",
				state: shipment.origin.location.state default "",
				country: shipment.origin.location.country default ""
			}
		},
		destination: {
			port: shipment.destination.port default "",
			location : {
				locCode: shipment.destination.location.locCode default "",
				city: shipment.destination.location.city default "",
				state: shipment.destination.location.state default "",
				country: shipment.destination.location.country default ""
			}
		},
		exemptCode: shipment.exemptCode default "",
		itn: shipment.itn default "",
		itnSource: shipment.itnSource default "",
		isSedIndicator: shipment.isSedIndicator default "",
		status: shipment.status default "",
		custNotifications: {
			custNotification: {
				id: shipment.custNotifications.custNotification.id default "",
				equipID: shipment.custNotifications.custNotification.equipID default "",
				carrierCode: shipment.custNotifications.custNotification.carrierCode default "",
				equipLength: shipment.custNotifications.custNotification.equipLength default "",
				equipCategory: shipment.custNotifications.custNotification.equipCategory default "",
				equipFleet: shipment.custNotifications.custNotification.equipFleet default "",
				railCarID: shipment.custNotifications.custNotification.railCarID default "",
				equipExitLoc: shipment.custNotifications.custNotification.equipExitLoc default "",
				equipExitDate: shipment.custNotifications.custNotification.equipExitDate default "",
				equipExitTime: shipment.custNotifications.custNotification.equipExitTime default "",
				equipExitTimeZone: shipment.custNotifications.custNotification.equipExitTimeZone default ""
			}
		},
		voyages: shipment.voyages default [] map  
                  ( (voy, indexOfVoy) -> 
                    {
			shipmentNumber: voy.shipmentNumber,
			voyageNumber: voy.voyageNumber default "",
			load: {
				//port: locPort(voy.load.port) default "",
				port: voy.load.port default "",
				sequence: voy.load.sequence default "",
				location: {
					sublocCode: voy.load.location.sublocCode default "",
					code: voy.load.location.code default "",
					city: voy.load.location.city default "",
					state: voy.load.location.state default "",
					country: voy.load.location.country default ""
				}
			},
			discharge: {
				port: voy.discharge.port default "",
				sequence : voy.discharge.sequence default "",
				location: {
					sublocCode: voy.discharge.location.sublocCode default "",
					code: voy.discharge.location.code default "",
					city: voy.discharge.location.city default "",
					state: voy.discharge.location.state default "",
					country: voy.discharge.location.countrys default ""
				}
			},
			estimateSailDate: voy.estimateSailDate replace "-" with "" default "",
			estimateArrivalDate: voy.estimateArrivalDate replace "-" with "" default "",
			actualSailDate: voy.actualSailDate replace "-" with "" default "",
			actualArrivalDate: voy.actualArrivalDate replace "-" with "" default "",
			vesselAbbreviation: voy.vesselAbbreviation default "",
			vesselName: voy.vesselName default "",
			vesselLloydsCode: voy.vesselLloydsCode default "",
			vesselCountry: voy.vesselCountry default "",
			vesselOwnerSCAC: voy.vesselOwnerSCAC default "",
			roldReason: voy.roldReason default ""
		}
             ),
		freightDetails: shipment.freightDetails default [] map 
              (
                  (freight,indexOfFreight) -> 
                  {
            Year	: freight.Year default "",
            VIN		: freight.VIN default "",
            Type	: freight.'Type' default "",
            ModelNum: freight.ModelNum default "",
            Model	: freight.Model default "",
            Color	: freight.Color default "",
            Manufacturer: freight.Manufacturer default "",
			freightId: freight.freightId,
			cargoType: freight.cargoType default "",
			declaredWeight: {
				value: freight.declaredWeight.value default 0,
				unitofMeasure: freight.declaredWeight.unitofMeasure default "",
				"type": freight.declaredWeight.'type' default ""
			},
			volume : {
				value: freight.volume.value default 0,
				unitofMeasure: freight.volume.unitofMeasure default ""
			},
			declaredValue: freight.declaredValue default 0,
			moveType: {
				originMode: freight.moveType.originMode default "",
				destMode: freight.moveType.destMode default "",
				moveTypeDesc: freight.moveType.moveTypeDesc default ""
			},
			freightQty: {
				value: freight.freightQty.value default 0,
				unitofMeasure: freight.freightQty.unitofMeasure default ""
			},
			referenceNbr: freight.referenceNbr default "",
			underDeckInd: freight.underDeckInd default "",
			transferInd: {
				origin: freight.transferInd.origin default "",
				destination: freight.transferInd.destination default ""
			},
			transferConInd: {
				origin: freight.transferConInd.origin default "",
				destination: freight.transferConInd.destination default ""
			},
			overDimInd: freight.overDimInd default "",
			roroInd: freight.roroInd default "",
			fleetUsedCd: freight.fleetUsedCd default "",
			povDealerCd: freight.povDealerCd default "",
			selfPropelInd: freight.selfPropelInd default "",
			weathrProtectInd: freight.weathrProtectInd default "",
			heavyLiftInd: freight.heavyLiftInd default "",
			craneInd: freight.craneInd default "",
			fumigateInd: freight.fumigateInd default "",
			length: {
				major: freight.length.major default 0,
				minor: freight.length.minor default 0
			},
			width: {
				major: freight.width.major default 0,
				minor: freight.width.minor default 0
			},
			height: {
				major: freight.height.major default 0,
				minor: freight.height.minor default 0
			},
			linearUom: freight.linearUom default "",
			lumberQty: {
				value: freight.lumberQty.value default 0,
				unitofMeasure: freight.lumberQty.unitofMeasure default ""
			},
			CommodityName: freight.CommodityName,
			CommodityCode: freight.commodityCode,
			commodities: freight.commodities default [] map 
                        ( 
                            (commodity,indexOfCommodity) -> 
                            {
				commodityId : commodity.commodityId,
				description: commodity.description default "",
				tariffNbr: commodity.tariffNbr default "",
				contractNbr: commodity.contractNbr default "",
				stcc: commodity.stcc default "",
				tliChapter: commodity.tliChapter default "",
				tliSub: commodity.tliSub default "",
				tliUserNbr: commodity.tliUserNbr default "",
				tliId: commodity.tliId default "",
				tliSrvc: commodity.tliSrvc default "",
				tliNbr: commodity.tliNbr default "",
				commodityCodeType: commodity.commodityCodeType default "",
				commodityCode: commodity.commodityCode default "",
				isHazardous: commodity.isHazardous as Boolean,
				prefix: if (commodity.isHazardous as Boolean == true) commodity.prefix else "",
				number: if (commodity.isHazardous as Boolean == true) commodity.number else "",
				primaryClass: commodity.primaryClass default "",
				subHazard2: commodity.subHazard2 default "",
				classType: commodity.classType default "",
				subHazard1: commodity.subHazard1 default "",
				imoClass: commodity.imoClass default "",
				dotName : commodity.dotName default "",
				technicalName: commodity.technicalName default "",
				isLimitedQuantity: commodity.isLimitedQuantity default "",
				isMarinePollutant: commodity.isMarinePollutant default "",
				emergencyContact: {
					name: commodity.emergencyContact.name default "",
					phoneNumber: commodity.emergencyContact.phoneNumber default ""
				},
				permitNumber: commodity.permitNumber default "",
				flashTemperature: {
					value: commodity.flashTemperature.value default "",
					unitofMeasure: commodity.flashTemperature.unitofMeasure default ""
				},
				requiredQtyInd: commodity.requiredQtyInd default "",
				reportedQty: commodity.reportedQty default "",
				packageGroup: commodity.packageGroup default "",
				quantity: {
					value: commodity.quantity.value default "",
					unitofMeasure: commodity.quantity.unitofMeasure default ""
				},
				weight: {
					value:  commodity.weight.value default 0.00,
					unitofMeasure: commodity.weight.unitofMeasure default "",
					"type": commodity.weight.'type' default ""
				},
				volume: {
					value:  commodity.volume.value default 0.00,
					unitofMeasure: commodity.volume.unitofMeasure default ""
				},
				imdgPage: commodity.imdgPage default "",
				"hazIMOLock": commodity.hazIMOLock default ""
			}
                  ),
			requirements: freight.requirements default [] map
                                          (
                          (equipreq,indexOfReq) -> 
                            {
				reqId : equipreq.reqId,
				quantity: equipreq.quantity default 0,
				category: equipreq.category default "",
				equipmentTypeCode: equipreq.equipmentTypeCode default "",
				length: equipreq.length default 0,
				temperature : {
					value: equipreq.temperature.value default "",
					unitofMeasure : equipreq.temperature.unitofMeasure default ""
				},
				ventilated: equipreq.ventilated default "",
				rrInd: equipreq.rrInd default "",
				cmcEquipInd: equipreq.cmcEquipInd default "",
				"type": equipreq.'type' default "",
				weight: {
					value: trim (equipreq.weight.value default ""),
					unitofMeasure : equipreq.weight.unitofMeasure default ""
				},
				highCubeInd: equipreq.highCubeInd default "",
				width: equipreq.width default 0,
				specEquipCd: equipreq.specEquipCd default "",
				tarpInd: equipreq.tarpInd default "",
				termsCd: equipreq.termsCd default "",
				spaceType: equipreq.spaceType default "",
				shipOwnEqPrefix: equipreq.shipOwnEqPrefix default "",
				shipOwnEqNbr: equipreq.shipOwnEqNbr default "",
				equipAvailLoc: equipreq.equipAvailLoc default "",
				equipAvailDt: equipreq.equipAvailDt default "",
				pickupCarrier: equipreq.pickupCarrier default "",
				instructions: equipreq.instructions default "",
				equipments : equipreq.equipments default []    map                                   
                                          (
                                                (equipass)  ->  
                                                {
					sequenceId: equipass.sequenceId,
					prefix : equipass.prefix default "",
					number: equipass.number default "",
					eqpOwnerSCAC: equipass.eqpOwnerSCAC default "",
					category: equipass.category default "",
					categoryLN: equipass.categoryLN default "",
					"type": equipass.'type' default "",
					isLoaded: equipass.isLoaded default "",
					setTemperature: {
						value: equipass.setTemperature.value default 0,
						unitofMeasure: equipass.setTemperature.unitofMeasure default ""
					},
					readTemperature: {
						value: equipass.readTemperature.value default 0,
						unitofMeasure: equipass.readTemperature.unitofMeasure default ""
					},
					verifiedGrossMass : {
						weight: {
							value: equipass.verifiedGrossMass.weight.value default 0,
							unitofMeasure: equipass.verifiedGrossMass.weight.unitofMeasure default ""
						},
						scaleWeight: {
							value: equipass.verifiedGrossMass.scaleWeight.value default 0,
							unitofMeasure: equipass.verifiedGrossMass.scaleWeight.unitofMeasure default "",
							"type": equipass.verifiedGrossMass.scaleWeight.'type' default ""
						}
					},
					responsibleParty: equipass.responsibleParty default "",
					authPermission: equipass.authPermission default "",
					date: equipass.date default "",
					sealNumbers: equipass.sealNumbers default [],
					receiveDate: equipass.receiveDate default "",
					cargoWeight: {
						value: equipass.cargoWeight.value default 0,
						unitofMeasure: equipass.cargoWeight.unitofMeasure default "",
						"type": equipass.cargoWeight.'type' default ""
					},
					tareWeight: {
						value: equipass.tareWeight.value default 0,
						unitofMeasure: equipass.tareWeight.unitofMeasure default ""
					},
					volume: {
						value: equipass.volume.value default 0,
						unitofMeasure: equipass.volume.unitofMeasure default ""
					},
					statusCode: equipass.statusCode default "",
					"asnISOEqp": equipass.asnISOEqp default ""
				}
                                          )
			}
                              )
		}                                           
              ),
		dockReceipts: shipment.dockReceipts default []  map
                  (
                        (receipt) ->  
                        {
			equipmentPrefix: receipt.equipmentPrefix default "",
			equipmentNumber: receipt.equipmentNumber default "",
			equipmentTypeCode: receipt.equipmentTypeCode default "",
			receiptNbr: receipt.receiptNbr default "",
			vin: receipt.vin default "",
			model: receipt.model default "",
			color: receipt.color default "",
			year: receipt.year default "",
			make: receipt.make default "",
			cubeVolume : {
				value: receipt.cubeVolume.value default 0,
				unitofMeasure: receipt.cubeVolume.unitofMeasure default ""
			},
			quantity: {
				value: receipt.quantity.value default 0,
				unitofMeasure: receipt.quantity.unitofMeasure default ""
			},
			weight: {
				value: receipt.weight.value default 0,
				unitofMeasure: receipt.weight.unitofMeasure default "",
				"type": receipt.weight.'type' default ""
			},
			receiveDate: receipt.receiveDate default "",
			status: receipt.status default "",
			description: receipt.description default "",
			releaseDate: receipt.releaseDate default "",
			releaseTime: receipt.releaseTime default "",
			releaseTimeZone: receipt.releaseTimeZone default "",
			returnTimeZone: receipt.returnTimeZone default "",
			releaseCarrier: receipt.releaseCarrier default "",
			returnDate: receipt.returnDate default "",
			returnTime: receipt.returnTime default "",
			noShowInd: receipt.noShowInd default "",
			maxDimension: {
				height: receipt.maxDimension.height default 0,
				length: receipt.maxDimension.length default 0,
				width: receipt.maxDimension.width default 0,
				unitOfMeasure: receipt.maxDimension.unitOfMeasure default ""
			},
			splitInd: receipt.splitInd default "",
			returnInd: receipt.returnInd default "",
			damageInd: receipt.damageInd default ""
		}                                                                       
                  )
	} 
     )
      ),
	isPartialResult: payload.isPartialResult default false,
	billOfLadingNumbers : payload.billOfLadingNumbers default [],
	bookingChargeLines: payload.bookingChargeLines default []
}