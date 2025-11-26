package co.com.cidenet.iso8583converter.util;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

import com.solab.iso8583.IsoMessage;
import com.solab.iso8583.IsoType;
import com.solab.iso8583.IsoValue;

import co.com.cidenet.iso8583converter.exception.InvalidValueException;

public class ISO8583Utils {

	/**
	 * Construye un objeto {@link ISO8583TYPE} a partir de un objeto
	 * {@link IsoMessage}
	 * 
	 * @param isoMessage
	 * @return
	 * @throws InvalidValueException
	 */
	public static ISO8583TYPE convertfromISO8583(final IsoMessage isoMessage) throws InvalidValueException {

		ISO8583TYPE iso8583Type = new ISO8583TYPE();
		IsoValue<?> field;
		IsoType type;
		String value;

		iso8583Type.setMTI(String.format("%04x", isoMessage.getType()));

		for (int i = 2; i <= 128; i++) {

			if (isoMessage.hasField(i)) {

				field = isoMessage.getField(i);
				value = field.toString();
				type = field.getType();

				try {

					if (type == IsoType.AMOUNT) {
						new BigDecimal(value);

					} else if (type == IsoType.NUMERIC || type == IsoType.DATE4 || type == IsoType.DATE10
							|| type == IsoType.DATE_EXP) {
						new BigInteger(value);

					}
				} catch (NumberFormatException e) {

					throw new InvalidValueException(
							"El valor: " + value + " recibido en el bit: " + i + " no es un número.");
				}

				switch (i) {
				case 2:
					iso8583Type.setPrimaryAccountNumber002(value);
					break;

				case 3:
					iso8583Type.setProcessingCode003(value);
					break;

				case 4:
					iso8583Type.setAmountTransaction004(value);
					break;

				case 5:
					iso8583Type.setAmountSettlement005(value);
					break;

				case 6:
					iso8583Type.setAmountCardholderBilling006(value);
					break;

				case 7:
					iso8583Type.setTransmissionDateTime007(value);
					break;

				case 8:
					iso8583Type.setAmountCardholderBillingFee008(value);
					break;

				case 9:
					iso8583Type.setConversionRateSettlement009(value);
					break;

				case 10:
					iso8583Type.setConversionRateCardholderBilling010(value);
					break;

				case 11:
					iso8583Type.setSystemTraceAuditNumber011(value);
					break;

				case 12:
					iso8583Type.setTimeLocalTransaction012(value);
					break;

				case 13:
					iso8583Type.setDateLocalTransaction013(value);
					break;

				case 14:
					iso8583Type.setDateExpiration014(value);
					break;

				case 15:
					iso8583Type.setDateSettlement015(value);
					break;

				case 16:
					iso8583Type.setDateConversion016(value);
					break;

				case 17:
					iso8583Type.setDateCapture017(value);
					break;

				case 18:
					iso8583Type.setMerchantType018(value);
					break;

				case 19:
					iso8583Type.setAcquiringInstitutionCountryCode019(value);
					break;

				case 20:
					iso8583Type.setPANExtendedCountryCode020(value);
					break;

				case 21:
					iso8583Type.setForwardingInstitutionCountryCode021(value);
					break;

				case 22:
					iso8583Type.setPointOfServiceEntryMode022(value);
					break;

				case 23:
					iso8583Type.setApplicationPANSequenceNumber023(value);
					break;

				case 24:
					iso8583Type.setFunctionCode024(value);
					break;

				case 25:
					iso8583Type.setPointOfServiceConditionCode025(value);
					break;

				case 26:
					iso8583Type.setPointOfServiceCaptureCode026(value);
					break;

				case 27:
					iso8583Type.setAuthorizingIdentificationResponseLength027(value);
					break;

				case 28:
					iso8583Type.setAmountTransactionFee028(value);
					break;

				case 29:
					iso8583Type.setAmountSettlementFee029(value);
					break;

				case 30:
					iso8583Type.setAmountTransactionProcessingFee030(value);
					break;

				case 31:
					iso8583Type.setAmountSettlementProcessingFee031(value);
					break;

				case 32:
					iso8583Type.setAcquiringInstitutionIdentificationCode032(value);
					break;

				case 33:
					iso8583Type.setForwardingInstitutionIdentificationCode033(value);
					break;

				case 34:
					iso8583Type.setPrimaryAccountNumberExtended034(value);
					break;

				case 35:
					iso8583Type.setTrack2Data035(value);
					break;

				case 36:
					iso8583Type.setTrack3Data036(value);
					break;

				case 37:
					iso8583Type.setRetrievalReferenceNumber037(value);
					break;

				case 38:
					iso8583Type.setAuthorizationIdentificationResponse038(value);
					break;

				case 39:
					iso8583Type.setResponseCode039(value);
					break;

				case 40:
					iso8583Type.setServiceRestrictionCode040(value);
					break;

				case 41:
					iso8583Type.setCardAcceptorTerminalIdentification041(value);
					break;

				case 42:
					iso8583Type.setCardAcceptorIdentificationCode042(value);
					break;

				case 43:
					iso8583Type.setCardAcceptorNameLocation043(value);
					break;

				case 44:
					iso8583Type.setAdditionalResponseData044(value);
					break;

				case 45:
					iso8583Type.setTrack1Data045(value);
					break;

				case 46:
					iso8583Type.setAdditionalDataISO046(value);
					break;

				case 47:
					iso8583Type.setAdditionalDataNational047(value);
					break;

				case 48:
					iso8583Type.setAdditionalDataPrivate048(value);
					break;

				case 49:
					iso8583Type.setCurrencyCodeTransaction049(value);
					break;

				case 50:
					iso8583Type.setCurrencyCodeSettlement050(value);
					break;

				case 51:
					iso8583Type.setCurrencyCodeCardholderBilling051(value);
					break;

				case 52:
					iso8583Type.setPersonalIdentificationNumberData052(value);
					break;

				case 53:
					iso8583Type.setSecurityRelatedControlInformation053(value);
					break;

				case 54:
					iso8583Type.setAdditionalAmounts054(value);
					break;

				case 55:
					iso8583Type.setReservedISO055(value);
					break;

				case 56:
					iso8583Type.setReservedISO056(value);
					break;

				case 57:
					iso8583Type.setReservedNational057(value);
					break;

				case 58:
					iso8583Type.setReservedNational058(value);
					break;

				case 59:
					iso8583Type.setReservedNational059(value);
					break;

				case 60:
					iso8583Type.setReservedNational060(value);
					break;

				case 61:
					iso8583Type.setReservedPrivate061(value);
					break;

				case 62:
					iso8583Type.setReservedPrivate062(value);
					break;

				case 63:
					iso8583Type.setReservedPrivate063(value);
					break;

				case 64:
					iso8583Type.setMessageAuthenticationCode064(value);
					break;

				case 65:
					iso8583Type.setBitmapExtended065(value);
					break;

				case 66:
					iso8583Type.setSettlementCode066(value);
					break;

				case 67:
					iso8583Type.setExtendedPaymentCode067(value);
					break;

				case 68:
					iso8583Type.setReceivingInstitutionCountryCode068(value);
					break;

				case 69:
					iso8583Type.setSettlementInstitutionCountryCode069(value);
					break;

				case 70:
					iso8583Type.setNetworkManagementInformationCode070(value);
					break;

				case 71:
					iso8583Type.setMessageNumber071(value);
					break;

				case 72:
					iso8583Type.setMessageNumberLast072(value);
					break;

				case 73:
					iso8583Type.setDateAction073(value);
					break;

				case 74:
					iso8583Type.setCreditsNumber074(value);
					break;

				case 75:
					iso8583Type.setCreditsReversalNumber075(value);
					break;

				case 76:
					iso8583Type.setDebitsNumber076(value);
					break;

				case 77:
					iso8583Type.setDebitsReversalNumber077(value);
					break;

				case 78:
					iso8583Type.setTransferNumber078(value);
					break;

				case 79:
					iso8583Type.setTransferReversalNumber079(value);
					break;

				case 80:
					iso8583Type.setInquiriesNumber080(value);
					break;

				case 81:
					iso8583Type.setAuthorizationsNumber081(value);
					break;

				case 82:
					iso8583Type.setCreditsProcessingFeeAmount082(value);
					break;

				case 83:
					iso8583Type.setCreditsTransactionFeeAmount083(value);
					break;

				case 84:
					iso8583Type.setDebitsProcessingFeeAmount084(value);
					break;

				case 85:
					iso8583Type.setDebitsTransactionFeeAmount085(value);
					break;

				case 86:
					iso8583Type.setCreditsAmount086(value);
					break;

				case 87:
					iso8583Type.setCreditsReversalAmount087(value);
					break;

				case 88:
					iso8583Type.setDebitsAmount088(value);
					break;

				case 89:
					iso8583Type.setDebitsReversalAmount089(value);
					break;

				case 90:
					iso8583Type.setOriginalDataElements090(value);
					break;

				case 91:
					iso8583Type.setFileUpdateCode091(value);
					break;

				case 92:
					iso8583Type.setFileSecurityCode092(value);
					break;

				case 93:
					iso8583Type.setResponseIndicator093(value);
					break;

				case 94:
					iso8583Type.setServiceIndicator094(value);
					break;

				case 95:
					iso8583Type.setReplacementAmounts095(value);
					break;

				case 96:
					iso8583Type.setMessageSecurityCode096(value);
					break;

				case 97:
					iso8583Type.setAmountNetSettlement097(value);
					break;

				case 98:
					iso8583Type.setPayee098(value);
					break;

				case 99:
					iso8583Type.setSettlementInstitutionIdentificationCode099(value);
					break;

				case 100:
					iso8583Type.setReceivingInstitutionIdentificationCode100(value);
					break;

				case 101:
					iso8583Type.setFileName101(value);
					break;

				case 102:
					iso8583Type.setAccountIdentification1102(value);
					break;

				case 103:
					iso8583Type.setAccountIdentification2103(value);
					break;

				case 104:
					iso8583Type.setTransactionDescription104(value);
					break;

				case 105:
					iso8583Type.setReservedForISOUse105(value);
					break;

				case 106:
					iso8583Type.setReservedForISOUse106(value);
					break;

				case 107:
					iso8583Type.setReservedForISOUse107(value);
					break;

				case 108:
					iso8583Type.setReservedForISOUse108(value);
					break;

				case 109:
					iso8583Type.setReservedForISOUse109(value);
					break;

				case 110:
					iso8583Type.setReservedForISOUse110(value);
					break;

				case 111:
					iso8583Type.setReservedForISOUse111(value);
					break;

				case 112:
					iso8583Type.setReservedForNationalUse112(value);
					break;

				case 113:
					iso8583Type.setReservedForNationalUse113(value);
					break;

				case 114:
					iso8583Type.setReservedForNationalUse114(value);
					break;

				case 115:
					iso8583Type.setReservedForNationalUse115(value);
					break;

				case 116:
					iso8583Type.setReservedForNationalUse116(value);
					break;

				case 117:
					iso8583Type.setReservedForNationalUse117(value);
					break;

				case 118:
					iso8583Type.setReservedForNationalUse118(value);
					break;

				case 119:
					iso8583Type.setReservedForNationalUse119(value);
					break;

				case 120:
					iso8583Type.setReservedForPrivateUse120(value);
					break;

				case 121:
					iso8583Type.setReservedForPrivateUse121(value);
					break;

				case 122:
					iso8583Type.setReservedForPrivateUse122(value);
					break;

				case 123:
					iso8583Type.setReservedForPrivateUse123(value);
					break;

				case 124:
					iso8583Type.setReservedForPrivateUse124(value);
					break;

				case 125:
					iso8583Type.setReservedForPrivateUse125(value);
					break;

				case 126:
					iso8583Type.setReservedForPrivateUse126(value);
					break;

				case 127:
					iso8583Type.setReservedForPrivateUse127(value);
					break;

				case 128:
					iso8583Type.setMessageAuthenticationCode128(value);
					break;
				}
			} else {
				continue;
			}

		}

		return iso8583Type;
	}

	/**
	 * Construye un mapa de {@link IsoValue} indexado por su posición a partir de un
	 * objeto {@link ISO8583TYPE}
	 * 
	 * @param iso8583Type
	 * @return
	 */
	public static Map<Integer, IsoValue<?>> createMapIsoValue(ISO8583TYPE iso8583Type) {

		Map<Integer, IsoValue<?>> fields = new HashMap<>();

		validateAndPut(fields, 2, IsoType.LLVAR, iso8583Type.getPrimaryAccountNumber002());
		validateAndPut(fields, 3, IsoType.NUMERIC, iso8583Type.getProcessingCode003(), 6);
		validateAndPut(fields, 4, IsoType.AMOUNT, iso8583Type.getAmountTransaction004(), 12);
		validateAndPut(fields, 5, IsoType.AMOUNT, iso8583Type.getAmountSettlement005(), 12);
		validateAndPut(fields, 6, IsoType.AMOUNT, iso8583Type.getAmountCardholderBilling006(), 12);
		validateAndPut(fields, 7, IsoType.DATE10, iso8583Type.getTransmissionDateTime007(), 10);
		validateAndPut(fields, 8, IsoType.NUMERIC, iso8583Type.getAmountCardholderBillingFee008(), 8);
		validateAndPut(fields, 9, IsoType.NUMERIC, iso8583Type.getConversionRateSettlement009(), 8);
		validateAndPut(fields, 10, IsoType.NUMERIC, iso8583Type.getConversionRateCardholderBilling010(), 8);
		validateAndPut(fields, 11, IsoType.NUMERIC, iso8583Type.getSystemTraceAuditNumber011(), 6);
		validateAndPut(fields, 12, IsoType.TIME, iso8583Type.getTimeLocalTransaction012());
		validateAndPut(fields, 13, IsoType.NUMERIC, iso8583Type.getDateLocalTransaction013(), 4);
		validateAndPut(fields, 14, IsoType.DATE_EXP, iso8583Type.getDateExpiration014());
		validateAndPut(fields, 15, IsoType.NUMERIC, iso8583Type.getDateSettlement015(), 4);
		validateAndPut(fields, 16, IsoType.NUMERIC, iso8583Type.getDateConversion016(), 4);
		validateAndPut(fields, 17, IsoType.NUMERIC, iso8583Type.getDateCapture017(), 4);
		validateAndPut(fields, 18, IsoType.NUMERIC, iso8583Type.getMerchantType018(), 4);
		validateAndPut(fields, 19, IsoType.NUMERIC, iso8583Type.getAcquiringInstitutionCountryCode019(), 3);
		validateAndPut(fields, 20, IsoType.NUMERIC, iso8583Type.getPANExtendedCountryCode020(), 3);
		validateAndPut(fields, 21, IsoType.NUMERIC, iso8583Type.getForwardingInstitutionCountryCode021(), 3);
		validateAndPut(fields, 22, IsoType.NUMERIC, iso8583Type.getPointOfServiceEntryMode022(), 3);
		validateAndPut(fields, 23, IsoType.NUMERIC, iso8583Type.getApplicationPANSequenceNumber023(), 3);
		validateAndPut(fields, 24, IsoType.NUMERIC, iso8583Type.getFunctionCode024(), 3);
		validateAndPut(fields, 25, IsoType.NUMERIC, iso8583Type.getPointOfServiceConditionCode025(), 2);
		validateAndPut(fields, 26, IsoType.NUMERIC, iso8583Type.getPointOfServiceCaptureCode026(), 2);
		validateAndPut(fields, 27, IsoType.NUMERIC, iso8583Type.getAuthorizingIdentificationResponseLength027(), 1);
		validateAndPut(fields, 28, IsoType.NUMERIC, iso8583Type.getAmountTransactionFee028(), 8);
		validateAndPut(fields, 29, IsoType.NUMERIC, iso8583Type.getAmountSettlementFee029(), 8);
		validateAndPut(fields, 30, IsoType.NUMERIC, iso8583Type.getAmountTransactionProcessingFee030(), 8);
		validateAndPut(fields, 31, IsoType.NUMERIC, iso8583Type.getAmountSettlementProcessingFee031(), 8);
		validateAndPut(fields, 32, IsoType.LLVAR, iso8583Type.getAcquiringInstitutionIdentificationCode032());
		validateAndPut(fields, 33, IsoType.LLVAR, iso8583Type.getForwardingInstitutionIdentificationCode033());
		validateAndPut(fields, 34, IsoType.LLVAR, iso8583Type.getPrimaryAccountNumberExtended034());
		validateAndPut(fields, 35, IsoType.LLVAR, iso8583Type.getTrack2Data035());
		validateAndPut(fields, 36, IsoType.LLLVAR, iso8583Type.getTrack3Data036());
		validateAndPut(fields, 37, IsoType.ALPHA, iso8583Type.getRetrievalReferenceNumber037(), 12);
		validateAndPut(fields, 38, IsoType.ALPHA, iso8583Type.getAuthorizationIdentificationResponse038(), 6);
		validateAndPut(fields, 39, IsoType.ALPHA, iso8583Type.getResponseCode039(), 2);
		validateAndPut(fields, 40, IsoType.ALPHA, iso8583Type.getServiceRestrictionCode040(), 3);
		validateAndPut(fields, 41, IsoType.ALPHA, iso8583Type.getCardAcceptorTerminalIdentification041(), 8);
		validateAndPut(fields, 42, IsoType.ALPHA, iso8583Type.getCardAcceptorIdentificationCode042(), 15);
		validateAndPut(fields, 43, IsoType.ALPHA, iso8583Type.getCardAcceptorNameLocation043(), 40);
		validateAndPut(fields, 44, IsoType.LLVAR, iso8583Type.getAdditionalResponseData044());
		validateAndPut(fields, 45, IsoType.LLVAR, iso8583Type.getTrack1Data045());
		validateAndPut(fields, 46, IsoType.LLLVAR, iso8583Type.getAdditionalDataISO046());
		validateAndPut(fields, 47, IsoType.LLLVAR, iso8583Type.getAdditionalDataNational047());
		validateAndPut(fields, 48, IsoType.LLLVAR, iso8583Type.getAdditionalDataPrivate048());
		validateAndPut(fields, 49, IsoType.ALPHA, iso8583Type.getCurrencyCodeTransaction049(), 3);
		validateAndPut(fields, 50, IsoType.ALPHA, iso8583Type.getCurrencyCodeSettlement050(), 3);
		validateAndPut(fields, 51, IsoType.ALPHA, iso8583Type.getCurrencyCodeCardholderBilling051(), 3);
		validateAndPut(fields, 52, IsoType.BINARY, iso8583Type.getPersonalIdentificationNumberData052(), 8);
		validateAndPut(fields, 53, IsoType.NUMERIC, iso8583Type.getSecurityRelatedControlInformation053(), 18);
		validateAndPut(fields, 54, IsoType.LLLVAR, iso8583Type.getAdditionalAmounts054());
		validateAndPut(fields, 55, IsoType.LLLVAR, iso8583Type.getReservedISO055());
		validateAndPut(fields, 56, IsoType.LLLVAR, iso8583Type.getReservedISO056());
		validateAndPut(fields, 57, IsoType.LLLVAR, iso8583Type.getReservedNational057());
		validateAndPut(fields, 58, IsoType.LLLVAR, iso8583Type.getReservedNational058());
		validateAndPut(fields, 59, IsoType.LLLVAR, iso8583Type.getReservedNational059());
		validateAndPut(fields, 60, IsoType.LLLVAR, iso8583Type.getReservedNational060());
		validateAndPut(fields, 61, IsoType.LLLVAR, iso8583Type.getReservedPrivate061());
		validateAndPut(fields, 62, IsoType.LLLVAR, iso8583Type.getReservedPrivate062());
		validateAndPut(fields, 63, IsoType.LLLVAR, iso8583Type.getReservedPrivate063());
		validateAndPut(fields, 64, IsoType.BINARY, iso8583Type.getMessageAuthenticationCode064(), 16);
		validateAndPut(fields, 65, IsoType.BINARY, iso8583Type.getBitmapExtended065(), 16);
		validateAndPut(fields, 66, IsoType.NUMERIC, iso8583Type.getSettlementCode066(), 1);
		validateAndPut(fields, 67, IsoType.NUMERIC, iso8583Type.getExtendedPaymentCode067(), 2);
		validateAndPut(fields, 68, IsoType.NUMERIC, iso8583Type.getReceivingInstitutionCountryCode068(), 3);
		validateAndPut(fields, 69, IsoType.NUMERIC, iso8583Type.getSettlementInstitutionCountryCode069(), 3);
		validateAndPut(fields, 70, IsoType.NUMERIC, iso8583Type.getNetworkManagementInformationCode070(), 3);
		validateAndPut(fields, 71, IsoType.NUMERIC, iso8583Type.getMessageNumber071(), 4);
		validateAndPut(fields, 72, IsoType.LLLVAR, iso8583Type.getMessageNumberLast072());
		validateAndPut(fields, 73, IsoType.NUMERIC, iso8583Type.getDateAction073(), 6);
		validateAndPut(fields, 74, IsoType.NUMERIC, iso8583Type.getCreditsNumber074(), 10);
		validateAndPut(fields, 75, IsoType.NUMERIC, iso8583Type.getCreditsReversalNumber075(), 10);
		validateAndPut(fields, 76, IsoType.NUMERIC, iso8583Type.getDebitsNumber076(), 10);
		validateAndPut(fields, 77, IsoType.NUMERIC, iso8583Type.getDebitsReversalNumber077(), 10);
		validateAndPut(fields, 78, IsoType.NUMERIC, iso8583Type.getTransferNumber078(), 10);
		validateAndPut(fields, 79, IsoType.NUMERIC, iso8583Type.getTransferReversalNumber079(), 10);
		validateAndPut(fields, 80, IsoType.NUMERIC, iso8583Type.getInquiriesNumber080(), 10);
		validateAndPut(fields, 81, IsoType.NUMERIC, iso8583Type.getAuthorizationsNumber081(), 10);
		validateAndPut(fields, 82, IsoType.NUMERIC, iso8583Type.getCreditsProcessingFeeAmount082(), 12);
		validateAndPut(fields, 83, IsoType.NUMERIC, iso8583Type.getCreditsTransactionFeeAmount083(), 12);
		validateAndPut(fields, 84, IsoType.NUMERIC, iso8583Type.getDebitsProcessingFeeAmount084(), 12);
		validateAndPut(fields, 85, IsoType.NUMERIC, iso8583Type.getDebitsTransactionFeeAmount085(), 12);
		validateAndPut(fields, 86, IsoType.NUMERIC, iso8583Type.getCreditsAmount086(), 15);
		validateAndPut(fields, 87, IsoType.NUMERIC, iso8583Type.getCreditsReversalAmount087(), 15);
		validateAndPut(fields, 88, IsoType.NUMERIC, iso8583Type.getDebitsAmount088(), 15);
		validateAndPut(fields, 89, IsoType.NUMERIC, iso8583Type.getDebitsReversalAmount089(), 15);
		validateAndPut(fields, 90, IsoType.NUMERIC, iso8583Type.getOriginalDataElements090(), 42);
		validateAndPut(fields, 91, IsoType.ALPHA, iso8583Type.getFileUpdateCode091(), 1);
		validateAndPut(fields, 92, IsoType.NUMERIC, iso8583Type.getFileSecurityCode092(), 2);
		validateAndPut(fields, 93, IsoType.NUMERIC, iso8583Type.getResponseIndicator093(), 5);
		validateAndPut(fields, 94, IsoType.ALPHA, iso8583Type.getServiceIndicator094(), 7);
		validateAndPut(fields, 95, IsoType.ALPHA, iso8583Type.getReplacementAmounts095(), 42);
		validateAndPut(fields, 96, IsoType.ALPHA, iso8583Type.getMessageSecurityCode096(), 8);
		validateAndPut(fields, 97, IsoType.NUMERIC, iso8583Type.getAmountNetSettlement097(), 16);
		validateAndPut(fields, 98, IsoType.ALPHA, iso8583Type.getPayee098(), 25);
		validateAndPut(fields, 99, IsoType.LLVAR, iso8583Type.getSettlementInstitutionIdentificationCode099());
		validateAndPut(fields, 100, IsoType.LLVAR, iso8583Type.getReceivingInstitutionIdentificationCode100());
		validateAndPut(fields, 101, IsoType.ALPHA, iso8583Type.getFileName101(), 17);
		validateAndPut(fields, 102, IsoType.LLVAR, iso8583Type.getAccountIdentification1102());
		validateAndPut(fields, 103, IsoType.LLVAR, iso8583Type.getAccountIdentification2103());
		validateAndPut(fields, 104, IsoType.LLLVAR, iso8583Type.getTransactionDescription104());
		validateAndPut(fields, 105, IsoType.LLLVAR, iso8583Type.getReservedForISOUse105());
		validateAndPut(fields, 106, IsoType.LLLVAR, iso8583Type.getReservedForISOUse106());
		validateAndPut(fields, 107, IsoType.LLLVAR, iso8583Type.getReservedForISOUse107());
		validateAndPut(fields, 108, IsoType.LLLVAR, iso8583Type.getReservedForISOUse108());
		validateAndPut(fields, 109, IsoType.LLLVAR, iso8583Type.getReservedForISOUse109());
		validateAndPut(fields, 110, IsoType.LLLVAR, iso8583Type.getReservedForISOUse110());
		validateAndPut(fields, 111, IsoType.LLLVAR, iso8583Type.getReservedForISOUse111());
		validateAndPut(fields, 112, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse112());
		validateAndPut(fields, 113, IsoType.LLVAR, iso8583Type.getReservedForNationalUse113());
		validateAndPut(fields, 114, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse114());
		validateAndPut(fields, 115, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse115());
		validateAndPut(fields, 116, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse116());
		validateAndPut(fields, 117, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse117());
		validateAndPut(fields, 118, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse118());
		validateAndPut(fields, 119, IsoType.LLLVAR, iso8583Type.getReservedForNationalUse119());
		validateAndPut(fields, 120, IsoType.LLLVAR, iso8583Type.getReservedForPrivateUse120());
		validateAndPut(fields, 121, IsoType.LLLVAR, iso8583Type.getReservedForPrivateUse121());
		validateAndPut(fields, 122, IsoType.LLLVAR, iso8583Type.getReservedForPrivateUse122());
		validateAndPut(fields, 123, IsoType.LLLVAR, iso8583Type.getReservedForPrivateUse123());
		validateAndPut(fields, 124, IsoType.LLLVAR, iso8583Type.getReservedForPrivateUse124());
		validateAndPut(fields, 125, IsoType.LLVAR, iso8583Type.getReservedForPrivateUse125());
		validateAndPut(fields, 126, IsoType.LLVAR, iso8583Type.getReservedForPrivateUse126());
		validateAndPut(fields, 127, IsoType.LLLVAR, iso8583Type.getReservedForPrivateUse127());
		validateAndPut(fields, 128, IsoType.BINARY, iso8583Type.getMessageAuthenticationCode128(), 16);

		return fields;
	}

	/**
	 * Se encarga de validar e insertar un campo en determinada posición en la lista
	 * de campos
	 * 
	 * @param fields
	 *            mapa de campos
	 * @param position
	 *            posición a insertar
	 * @param type
	 *            tipo del campo a insertar
	 * @param value
	 *            valor del campo a insertar
	 * @throws InvalidValueException
	 */
	private static final void validateAndPut(Map<Integer, IsoValue<?>> fields, final int position, IsoType type,
			final String value) throws InvalidValueException {
		validateAndPut(fields, position, type, value, 0);
	}

	/**
	 * Se encarga de validar e insertar un campo en determinada posición en la lista
	 * de campos
	 * 
	 * @param fields
	 *            mapa de campos
	 * @param position
	 *            posición a insertar
	 * @param type
	 *            tipo del campo a insertar
	 * @param value
	 *            valor del campo a insertar
	 * @param lenght
	 *            tamaño del campo
	 * @throws InvalidValueException
	 */
	private static final void validateAndPut(Map<Integer, IsoValue<?>> fields, final int position, IsoType type,
			final String value, final int lenght) throws InvalidValueException {

			// Los campos para los cuales se reciba el nodo serán incluidos
		if (value != null /*&& !value.isEmpty()*/) {

			try {

				if (type == IsoType.AMOUNT) {
					new BigDecimal(value);

				} else if (type == IsoType.NUMERIC || type == IsoType.DATE4 || type == IsoType.DATE10
						|| type == IsoType.DATE_EXP) {
					new BigInteger(value);
				}
			} catch (NumberFormatException e) {

				throw new InvalidValueException(
						"El valor: " + value + " ingresado en el bit: " + position + " no es un número. ");
			}

			if (lenght > 0) {
				fields.put(position, new IsoValue<Object>(type, value, lenght));
			} else {
				fields.put(position, new IsoValue<Object>(type, value));
			}
		}

	}

}
