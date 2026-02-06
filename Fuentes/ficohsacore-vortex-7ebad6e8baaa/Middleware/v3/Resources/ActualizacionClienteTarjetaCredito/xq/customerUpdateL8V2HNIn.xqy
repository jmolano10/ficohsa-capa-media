xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizacionClienteTarjetaCredito" element="ns0:actualizacionClienteTarjetaCredito" location="../xsd/actualizacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CustomerUpdateL8V2Request" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$ptEquivalencias" type="ns2:T_EQUIVALENCIA_CAT_OUT" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos_v2/xsd/consultaEquivalenciasCatalogos_v2_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizacionClienteTarjetaCreditoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos_v2";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ActualizacionClienteTarjetaCredito/xq/customerUpdateL8V2HNIn/";

declare function valorCatalogoOSBToAPP($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {

	let $responseCatalogo := $equivalencias/ns2:PT_EQUIVALENCIAS_SALIDA_ITEM[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM/ns2:APLICACION = $aplicacion and 
															  ns2:VALOR_CATALOGO = $valor]
															  
	let $retorno := fn:string($responseCatalogo[1]/ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM/ns2:VALOR_EQUIVALENCIA/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:customerUpdateL8V2HNIn($actualizacionClienteTarjetaCredito as element(ns0:actualizacionClienteTarjetaCredito),
	$ptEquivalencias as element())
    as element(ns1:CustomerUpdateL8V2Request) {
        <ns1:CustomerUpdateL8V2Request>
            <AZXGCI-ORG>{ data($actualizacionClienteTarjetaCredito/ORG) }</AZXGCI-ORG>
            <AZXGCI-CARD-NBR>{ fn-bea:pad-left(data($actualizacionClienteTarjetaCredito/PRODUCT_NUMBER), 19, '0') }</AZXGCI-CARD-NBR>
            <AZXGCI-NBR-TYPE>{ data($actualizacionClienteTarjetaCredito/PRODUCT_TYPE) }</AZXGCI-NBR-TYPE>
            <AZXGCI-FOREIGN-USE>{ data($actualizacionClienteTarjetaCredito/FOREIGN_INDICATOR) }</AZXGCI-FOREIGN-USE>
            <AZXGCI-DEMOGRAPHIC-DATAIND>{ data($actualizacionClienteTarjetaCredito/DEMOGRAPHIC_DATA_INDICATOR) }</AZXGCI-DEMOGRAPHIC-DATAIND>
            <AZXGCI-USER-DATA-IND>{ data($actualizacionClienteTarjetaCredito/USER_DATA_INDICATOR) }</AZXGCI-USER-DATA-IND>
            <AZXGCI-VIP-STATUS>{ data($actualizacionClienteTarjetaCredito/VIP_STATUS) }</AZXGCI-VIP-STATUS>
            <AZXGCI-STATUS>{ data($actualizacionClienteTarjetaCredito/CUSTOMER_STATUS) }</AZXGCI-STATUS>
            <AZXGCI-SIC-CODE xsi:nil="true"/>
            <AZXGCI-TITLE xsi:nil="true"/>
        	{ 
        		let $MARITAL_STATUS := fn:string($actualizacionClienteTarjetaCredito/MARITAL_STATUS/text())
        		return 
        			if($MARITAL_STATUS != "") then (  
            			<AZXGCI-MARITAL-STATUS>{ valorCatalogoOSBToAPP($MARITAL_STATUS, 'VISION+HN', '2', $ptEquivalencias) }</AZXGCI-MARITAL-STATUS>
            		)else(
            			<AZXGCI-MARITAL-STATUS xsi:nil="true"/>
            		)
        	}
        	{ 
        		let $NAME_1 := fn:string($actualizacionClienteTarjetaCredito/NAME_1/text())
        		return
        			if($NAME_1 != "") then (  
            			<AZXGCI-NAME-LINE-1>{ $NAME_1 }</AZXGCI-NAME-LINE-1>
            		)else(
            			<AZXGCI-NAME-LINE-1 xsi:nil="true"/>
            		) 
        	}
        	{
        		let $TYPE_NAME_1 := fn:string($actualizacionClienteTarjetaCredito/TYPE_NAME_1/text())
        		return 
        			if($TYPE_NAME_1 != "") then(
        				<AZXGCI-NAME-LINE-1-TYP>{ data($TYPE_NAME_1) }</AZXGCI-NAME-LINE-1-TYP> 
        			)else(
        				<AZXGCI-NAME-LINE-1-TYP xsi:nil="true"/>
        			)
        	}
        	{
        		let $NAME_2 := fn:string($actualizacionClienteTarjetaCredito/NAME_2/text())
        		return
            		if($NAME_2 != "") then(
            			<AZXGCI-NAME-LINE-2>{ $NAME_2 }</AZXGCI-NAME-LINE-2>
            		)else(
            			<AZXGCI-NAME-LINE-2 xsi:nil="true"/>
            		) 
        	}
        	{
        		let $TYPE_NAME_2 := fn:string($actualizacionClienteTarjetaCredito/TYPE_NAME_2/text())
        		return
        			if($TYPE_NAME_2 != "") then(
        				<AZXGCI-NAME-LINE-2-TYP>{ data($TYPE_NAME_2) }</AZXGCI-NAME-LINE-2-TYP>
        			)else(
        				<AZXGCI-NAME-LINE-2-TYP xsi:nil="true"/>
        			)
        	}
        	{
        		let $NAME_3 := fn:string($actualizacionClienteTarjetaCredito/NAME_3/text())
        		return
        			if($NAME_3 != "") then(
        				<AZXGCI-NAME-LINE-3>{ $NAME_3 }</AZXGCI-NAME-LINE-3>		
        			)else(
        				<AZXGCI-NAME-LINE-3 xsi:nil="true"/>
        			)
        	}
        	{
        		let $TYPE_NAME_3 := fn:string($actualizacionClienteTarjetaCredito/TYPE_NAME_3/text())
        		return
        			if($TYPE_NAME_3 != "") then(
        				<AZXGCI-NAME-LINE-3-TYP>{ data($TYPE_NAME_3) }</AZXGCI-NAME-LINE-3-TYP>		
        			)else(
        				<AZXGCI-NAME-LINE-3-TYP xsi:nil="true"/>
        			)
        	}            
        	{
        		let $HOUSE_NUMBER := fn:string($actualizacionClienteTarjetaCredito/HOUSE_NUMBER/text())
        		return 
        			if($HOUSE_NUMBER != "") then(
	        			<AZXGCI-HOUSE-NBR>{ $HOUSE_NUMBER }</AZXGCI-HOUSE-NBR>
        			)else(
        				<AZXGCI-HOUSE-NBR xsi:nil="true"/>
        			)
        	}
        	{
        		let $HOUSE_NAME := fn:string($actualizacionClienteTarjetaCredito/HOUSE_NAME/text())
        		return
        			if($HOUSE_NAME != "") then(
        				<AZXGCI-HOUSE-NAME>{ $HOUSE_NAME }</AZXGCI-HOUSE-NAME>			
        			)else(
        				<AZXGCI-HOUSE-NAME xsi:nil="true"/>
        			)
        	}
        	{
        		let $HOME_ADDRESS_LINE_1 := fn:string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_1/text())
        		return
        			if($HOME_ADDRESS_LINE_1 != "") then(
        				<AZXGCI-ADDR-1>{ $HOME_ADDRESS_LINE_1 }</AZXGCI-ADDR-1>		
        			)else(
        				<AZXGCI-ADDR-1 xsi:nil="true"/>
        			)
        	}
        	{
        		let $HOME_ADDRESS_LINE_2 := fn:string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_2/text())
        		return
        			if($HOME_ADDRESS_LINE_2 != "") then(
        				<AZXGCI-ADDR-2>{ $HOME_ADDRESS_LINE_2 }</AZXGCI-ADDR-2>		
        			)else(
        				<AZXGCI-ADDR-2 xsi:nil="true"/>
        			)
        	}
        	{
        		let $HOME_ADDRESS_LINE_3 := fn:string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_3/text())
        		return
        			if($HOME_ADDRESS_LINE_3 != "") then(
        				<AZXGCI-ADDR-3>{ $HOME_ADDRESS_LINE_3 }</AZXGCI-ADDR-3>		
        			)else(
        				<AZXGCI-ADDR-3 xsi:nil="true"/>
        			)
        	}
        	{
        		let $HOME_ADDRESS_LINE_4 := fn:string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_4/text())
        		return
        			if($HOME_ADDRESS_LINE_4 != "") then(
        				<AZXGCI-ADDR-4>{ $HOME_ADDRESS_LINE_4 }</AZXGCI-ADDR-4>			
        			)else(
        				<AZXGCI-ADDR-4 xsi:nil="true"/>
        			)
        	}
        	{
        		let $CITY := fn:string($actualizacionClienteTarjetaCredito/CITY/text())
        		return
        			if($CITY != "") then(
        				<AZXGCI-CITY>{ valorCatalogoOSBToAPP($CITY, 'VISION+HN', '8', $ptEquivalencias) }</AZXGCI-CITY>			
        			)else(
        				<AZXGCI-CITY xsi:nil="true"/>
        			)
        	}
        	{
        		let $STATE := fn:string($actualizacionClienteTarjetaCredito/STATE/text())
        		return
        			if($STATE != "") then(
        				<AZXGCI-STATE>{ $STATE }</AZXGCI-STATE>		
        			)else(
        				<AZXGCI-STATE xsi:nil="true"/>
        			)
        	}
        	{
        		let $ZIP_CODE := fn:string($actualizacionClienteTarjetaCredito/ZIP_CODE/text())
        		return
        			if($ZIP_CODE != "") then(
						<AZXGCI-PSTL-CD>{ valorCatalogoOSBToAPP($ZIP_CODE, 'VISION+HN', '7', $ptEquivalencias) }</AZXGCI-PSTL-CD>        			
        			)else(
        				<AZXGCI-PSTL-CD xsi:nil="true"/>
        			)
        	}
        	{
				let $COUNTRY_OF_RESIDENCE := fn:string($actualizacionClienteTarjetaCredito/COUNTRY_OF_RESIDENCE/text())
				return
					if($COUNTRY_OF_RESIDENCE != "") then(
						<AZXGCI-CNTRY-CD>{ $COUNTRY_OF_RESIDENCE }</AZXGCI-CNTRY-CD>		
					)else(
						<AZXGCI-CNTRY-CD xsi:nil="true"/>
					)
        	}
        	{
        		let $RESIDENCE_TYPE := fn:string($actualizacionClienteTarjetaCredito/RESIDENCE_TYPE/text())
        		return
        			if($RESIDENCE_TYPE != "") then(
        				<AZXGCI-OWN-RENT-RESID-FLAG>{ data($RESIDENCE_TYPE) }</AZXGCI-OWN-RENT-RESID-FLAG>		
        			)else(
        				<AZXGCI-OWN-RENT-RESID-FLAG xsi:nil="true"/>
        			)
        	}
        	{
        		let $LANGUAGE := fn:string($actualizacionClienteTarjetaCredito/LANGUAGE/text())
        		return
        			if($LANGUAGE != "") then(
        				<AZXGCI-LANGUAGE-IND>{ $LANGUAGE }</AZXGCI-LANGUAGE-IND>		
        			)else(
        				<AZXGCI-LANGUAGE-IND xsi:nil="true"/>
        			)
        	}
        	
        	(:Validacion para campo MAILING-LIST:)
        	{
        		let $MAILING_LIST := fn:string($actualizacionClienteTarjetaCredito/MAILING_LIST/text())
        		return
        			if($MAILING_LIST != "") then(
        				<AZXGCI-MAILING-LIST>{ data($MAILING_LIST) }</AZXGCI-MAILING-LIST>		
        			)else(
        				<AZXGCI-MAILING-LIST>E</AZXGCI-MAILING-LIST>
        			)
        	}
        	(:Validacion para campo MAILING-LIST:)
        	{
        		let $CONTACT_INDICATOR := fn:string($actualizacionClienteTarjetaCredito/CONTACT_INDICATOR/text())
        		return
        			if($CONTACT_INDICATOR != "") then(
        				<AZXGCI-CONTACT-IND>{ data($CONTACT_INDICATOR) }</AZXGCI-CONTACT-IND>		
        			)else(
        				<AZXGCI-CONTACT-IND xsi:nil="true"/>
        			)
        	}
            {
            	let $GENDER := fn:string($actualizacionClienteTarjetaCredito/GENDER/text())
        		return
        			if($GENDER != "") then(
        				<AZXGCI-GENDER-CODE>{ valorCatalogoOSBToAPP(data($GENDER), 'VISION+HN', '1', $ptEquivalencias) }</AZXGCI-GENDER-CODE>		
        			)else(
        				<AZXGCI-GENDER-CODE xsi:nil="true"/>
        			)
            }
            {
            	let $HOME_PHONE_NUMBER := fn:string($actualizacionClienteTarjetaCredito/HOME_PHONE_NUMBER/text())
        		return
        			if($HOME_PHONE_NUMBER != "") then(
        				<AZXGCI-HOME-PHONE>{ $HOME_PHONE_NUMBER }</AZXGCI-HOME-PHONE>		
        			)else(
        				<AZXGCI-HOME-PHONE xsi:nil="true"/>
        			)
            }
            <AZXGCI-HOME-PHONE-IND xsi:nil="true"/>
            {
            	let $FAX_PHONE := fn:string($actualizacionClienteTarjetaCredito/FAX_PHONE/text())
        		return
        			if($FAX_PHONE != "") then(
        				<AZXGCI-FAX-PHONE>{ $FAX_PHONE }</AZXGCI-FAX-PHONE>		
        			)else(
        				<AZXGCI-FAX-PHONE xsi:nil="true"/>
        			)
            }
            {
            	let $PHONE_INDICATOR := fn:string($actualizacionClienteTarjetaCredito/PHONE_INDICATOR/text())
        		return
        			if($PHONE_INDICATOR != "") then(
        				<AZXGCI-FAX-PHONE-IND>{ data($PHONE_INDICATOR) }</AZXGCI-FAX-PHONE-IND>		
        			)else(
        				<AZXGCI-FAX-PHONE-IND xsi:nil="true"/>
        			)
            }
            {
            	let $MOBILE_PHONE := fn:string($actualizacionClienteTarjetaCredito/MOBILE_PHONE/text())
        		return
        			if($MOBILE_PHONE != "") then(
        				<AZXGCI-MOBILE-PHONE>{ $MOBILE_PHONE }</AZXGCI-MOBILE-PHONE>		
        			)else(
        				<AZXGCI-MOBILE-PHONE xsi:nil="true"/>
        			)
            }
            {
            	let $MOBILE_INDICATOR := fn:string($actualizacionClienteTarjetaCredito/MOBILE_INDICATOR/text())
        		return
        			if($MOBILE_INDICATOR != "") then(
        				<AZXGCI-MOBILE-PHONE-IND>{ data($MOBILE_INDICATOR) }</AZXGCI-MOBILE-PHONE-IND>		
        			)else(
        				<AZXGCI-MOBILE-PHONE-IND xsi:nil="true"/>
        			)
            }
            {
            	let $BIRTH_DATE := fn:string($actualizacionClienteTarjetaCredito/BIRTH_DATE/text())
        		return
        			if($BIRTH_DATE != "") then(
        				<AZXGCI-DOB>{ data($BIRTH_DATE) }</AZXGCI-DOB>		
        			)else(
        				<AZXGCI-DOB xsi:nil="true"/>
        			)
            }
            {
            	let $COUNTRY_OF_ISSUE_DOC2 := fn:string($actualizacionClienteTarjetaCredito/COUNTRY_OF_ISSUE_DOC2/text())
        		return
        			if($COUNTRY_OF_ISSUE_DOC2 != "") then(
        				<AZXGCI-DL-CNTRY>{ $COUNTRY_OF_ISSUE_DOC2 }</AZXGCI-DL-CNTRY>		
        			)else(
        				<AZXGCI-DL-CNTRY xsi:nil="true"/>
        			)
            }
            <AZXGCI-DL-STATE xsi:nil="true"/>
            {
            	let $DRIVERS_LICENSE := fn:string($actualizacionClienteTarjetaCredito/DRIVERS_LICENSE/text())
        		return
        			if($DRIVERS_LICENSE != "") then(
        				<AZXGCI-DL-NBR>{ $DRIVERS_LICENSE }</AZXGCI-DL-NBR>		
        			)else(
        				<AZXGCI-DL-NBR xsi:nil="true"/>
        			)
            }
            {
            	let $DOCUMENT_TYPE_1 := fn:string($actualizacionClienteTarjetaCredito/DOCUMENT_TYPE_1/text())
        		return
        			if($DOCUMENT_TYPE_1 != "") then(
        				<AZXGCI-TAX-ID-TYP>{ valorCatalogoOSBToAPP(data($DOCUMENT_TYPE_1), 'VISION+HN', '4', $ptEquivalencias) }</AZXGCI-TAX-ID-TYP>		
        			)else(
        				<AZXGCI-TAX-ID-TYP xsi:nil="true"/>
        			)
            }
            {
            	let $DOCUMENT_ID_1 := fn:string($actualizacionClienteTarjetaCredito/DOCUMENT_ID_1/text())
        		return
        			if($DOCUMENT_ID_1 != "") then(
        				<AZXGCI-TAX-ID>{ $DOCUMENT_ID_1 }</AZXGCI-TAX-ID>		
        			)else(
        				<AZXGCI-TAX-ID xsi:nil="true"/>
        			)
            }
            <AZXGCI-1099C-W9-DATE-FILED xsi:nil="true"/>
            {
            	let $WORKPLACE := fn:string($actualizacionClienteTarjetaCredito/WORKPLACE/text())
        		return
        			if($WORKPLACE != "") then(
        				<AZXGCI-EMPLOYER>{ $WORKPLACE }</AZXGCI-EMPLOYER>		
        			)else(
        				<AZXGCI-EMPLOYER xsi:nil="true"/>
        			)
            }
          	{
          		let $WORK_ADDRESS_1 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_1/text())
        		return
        			if($WORK_ADDRESS_1 != "") then(
        				<AZXGCI-EMPLOYER-ADDR-1>{ $WORK_ADDRESS_1 }</AZXGCI-EMPLOYER-ADDR-1>		
        			)else(
        				<AZXGCI-EMPLOYER-ADDR-1 xsi:nil="true"/>
        			)
          	}
          	{
          		let $WORK_ADDRESS_2 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_2/text())
        		return
        			if($WORK_ADDRESS_2 != "") then(
        				<AZXGCI-EMPLOYER-ADDR-2>{ $WORK_ADDRESS_2 }</AZXGCI-EMPLOYER-ADDR-2>		
        			)else(
        				<AZXGCI-EMPLOYER-ADDR-2 xsi:nil="true"/>
        			)
          	}
            {
            	let $WORK_PHONE_NUMBER := fn:string($actualizacionClienteTarjetaCredito/WORK_PHONE_NUMBER/text())
        		return
        			if($WORK_PHONE_NUMBER != "") then(
        				<AZXGCI-EMP-PHONE>{ $WORK_PHONE_NUMBER }</AZXGCI-EMP-PHONE>		
        			)else(
        				<AZXGCI-EMP-PHONE xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_EXTENSION := fn:string($actualizacionClienteTarjetaCredito/WORK_EXTENSION/text())
        		return
        			if($WORK_EXTENSION != "") then(
        				<AZXGCI-EMP-PHONE-EXTN>{ $WORK_EXTENSION }</AZXGCI-EMP-PHONE-EXTN>		
        			)else(
        				<AZXGCI-EMP-PHONE-EXTN xsi:nil="true"/>
        			)
            }            
            <AZXGCI-EMP-PHONE-FLAG xsi:nil="true"/>
            {
            	let $PROFESSION := fn:string($actualizacionClienteTarjetaCredito/PROFESSION/text())
        		return
        			if($PROFESSION != "") then(
        				<AZXGCI-POSITION>{ valorCatalogoOSBToAPP($PROFESSION, 'VISION+HN', '3', $ptEquivalencias) }</AZXGCI-POSITION>		
        			)else(
        				<AZXGCI-POSITION xsi:nil="true"/>
        			)
            }
            {
            	let $RELATIVE_NAME := fn:string($actualizacionClienteTarjetaCredito/RELATIVE_NAME/text())
        		return
        			if($RELATIVE_NAME != "") then(
        				<AZXGCI-RELATIVE-NAME>{ $RELATIVE_NAME }</AZXGCI-RELATIVE-NAME>		
        			)else(
        				<AZXGCI-RELATIVE-NAME xsi:nil="true"/>
        			)
            }
            {
            	let $DEPENDENTS := fn:string($actualizacionClienteTarjetaCredito/DEPENDENTS/text())
        		return
        			if($DEPENDENTS != "") then(
        				<AZXGCI-NBR-OF-DEPENDENTS>{ data($DEPENDENTS) }</AZXGCI-NBR-OF-DEPENDENTS>		
        			)else(
        				<AZXGCI-NBR-OF-DEPENDENTS xsi:nil="true"/>
        			)
            }
            {
                for $EMAIL in data($actualizacionClienteTarjetaCredito/EMAIL)
                return
                    <AZXGCI-EMAIL>{ $EMAIL }</AZXGCI-EMAIL>
            }
            <AZXGCI-EMAIL-IND xsi:nil="true"/>
            <AZXGCI-SMS-IND xsi:nil="true"/>
            {
            	let $NAMES := fn:string($actualizacionClienteTarjetaCredito/NAMES/text())
        		return
        			if($NAMES != "") then(
        				<AZXGCI-FIRST-NAME>{ $NAMES }</AZXGCI-FIRST-NAME>		
        			)else(
        				<AZXGCI-FIRST-NAME xsi:nil="true"/>
        			)
            }
            <AZXGCI-MIDDLE-NAME xsi:nil="true"/>
            {
            	let $LAST_NAMES := fn:string($actualizacionClienteTarjetaCredito/LAST_NAMES/text())
        		return
        			if($LAST_NAMES != "") then(
        				<AZXGCI-LAST-NAME>{ $LAST_NAMES }</AZXGCI-LAST-NAME>		
        			)else(
        				<AZXGCI-LAST-NAME xsi:nil="true"/>
        			)
            }
            <AZXGCI-SUFFIX xsi:nil="true"/>
            {
            	let $BIRTH_COUNTRY := fn:string($actualizacionClienteTarjetaCredito/BIRTH_COUNTRY/text())
        		return
        			if($BIRTH_COUNTRY != "") then(
        				<AZXGCI-COUNTY>{ $BIRTH_COUNTRY }</AZXGCI-COUNTY>		
        			)else(
        				<AZXGCI-COUNTY xsi:nil="true"/>
        			)
            }
            {
            	let $CHANEL_CODE_1 := fn:string($actualizacionClienteTarjetaCredito/CHANEL_CODE/CHANEL_CODE_1/text())
        		return
        			if($CHANEL_CODE_1 != "") then(
        				<AZXGCI-MEMO-1>{ $CHANEL_CODE_1 }</AZXGCI-MEMO-1>		
        			)else(
        				<AZXGCI-MEMO-1 xsi:nil="true"/>
        			)
            }
            {
            	let $CHANEL_CODE_2 := fn:string($actualizacionClienteTarjetaCredito/CHANEL_CODE/CHANEL_CODE_2/text())
        		return
        			if($CHANEL_CODE_2 != "") then(
        				<AZXGCI-MEMO-2>{ $CHANEL_CODE_2 }</AZXGCI-MEMO-2>		
        			)else(
        				<AZXGCI-MEMO-2 xsi:nil="true"/>
        			)
            }
            {
            	let $EMPLOYMENT_YEARS := fn:string($actualizacionClienteTarjetaCredito/EMPLOYMENT_YEARS/text())
        		return
        			if($EMPLOYMENT_YEARS != "") then(
        				<AZXGCI-USER-1>{ $EMPLOYMENT_YEARS }</AZXGCI-USER-1>		
        			)else(
        				<AZXGCI-USER-1 xsi:nil="true"/>
        			)
            }
            {
            	let $EMPLOYMENT_MONTHS := fn:string($actualizacionClienteTarjetaCredito/EMPLOYMENT_MONTHS/text())
        		return
        			if($EMPLOYMENT_MONTHS != "") then(
        				<AZXGCI-USER-2>{ $EMPLOYMENT_MONTHS }</AZXGCI-USER-2>		
        			)else(
        				<AZXGCI-USER-2 xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_TITLE := fn:string($actualizacionClienteTarjetaCredito/WORK_TITLE/text())
        		return
        			if($WORK_TITLE != "") then(
        				<AZXGCI-USER-3>{ $WORK_TITLE }</AZXGCI-USER-3>		
        			)else(
        				<AZXGCI-USER-3 xsi:nil="true"/>
        			)
            }
            <AZXGCI-USER-4 xsi:nil="true"/>
            <AZXGCI-USER-5 xsi:nil="true"/>
            {
            	let $SEGMENT := fn:string($actualizacionClienteTarjetaCredito/SEGMENT/text())
        		return
        			if($SEGMENT != "") then(
        				<AZXGCI-USER-6>{ $SEGMENT }</AZXGCI-USER-6>		
        			)else(
        				<AZXGCI-USER-6 xsi:nil="true"/>
        			)
            }
            <AZXGCI-USER-7 xsi:nil="true"/>
            {
            	let $PEP_CLIENT := fn:string($actualizacionClienteTarjetaCredito/PEP_CLIENT/text())
        		return
        			if($PEP_CLIENT != "") then(
        				<AZXGCI-USER-8>{ $PEP_CLIENT }</AZXGCI-USER-8>		
        			)else(
        				<AZXGCI-USER-8 xsi:nil="true"/>
        			)
            }
            <AZXGCI-USER-9 xsi:nil="true"/>
            {
            	let $EXPIRATION_DATE_1 := fn:string($actualizacionClienteTarjetaCredito/EXPIRATION_DATE_1/text())
        		return
        			if($EXPIRATION_DATE_1 != "") then(
        				<AZXGCI-USER-10>{ data($EXPIRATION_DATE_1) }</AZXGCI-USER-10>		
        			)else(
        				<AZXGCI-USER-10 xsi:nil="true"/>
        			)
            }
            {
            	let $ISSUE_DATE_1 := fn:string($actualizacionClienteTarjetaCredito/ISSUE_DATE_1/text())
        		return
        			if($ISSUE_DATE_1 != "") then(
        				<AZXGCI-USER-11>{ data($ISSUE_DATE_1) }</AZXGCI-USER-11>		
        			)else(
        				<AZXGCI-USER-11 xsi:nil="true"/>
        			)
            }
            {
            	let $COUNTRY_ISSUE_PASSPORT := fn:string($actualizacionClienteTarjetaCredito/COUNTRY_ISSUE_PASSPORT/text())
        		return
        			if($COUNTRY_ISSUE_PASSPORT != "") then(
        				<AZXGCI-USER-12>{ $COUNTRY_ISSUE_PASSPORT }</AZXGCI-USER-12>		
        			)else(
        				<AZXGCI-USER-12 xsi:nil="true"/>
        			)
            }
            <AZXGCI-USER-13 xsi:nil="true"/>
            {
            	let $STUDY_GRADE := fn:string($actualizacionClienteTarjetaCredito/STUDY_GRADE/text())
        		return
        			if($STUDY_GRADE != "") then(
        				<AZXGCI-USER-14>{ $STUDY_GRADE }</AZXGCI-USER-14>		
        			)else(
        				<AZXGCI-USER-14 xsi:nil="true"/>
        			)
            }
            {
            	let $INCOMES := fn:string($actualizacionClienteTarjetaCredito/INCOMES/text())
        		return
        			if($INCOMES != "") then(
        				<AZXGCI-USER-15>{ $INCOMES }</AZXGCI-USER-15>		
        			)else(
        				<AZXGCI-USER-15 xsi:nil="true"/>
        			)
            }
            {
            	let $OTHERS_INCOMES := fn:string($actualizacionClienteTarjetaCredito/OTHERS_INCOMES/text())
        		return
        			if($OTHERS_INCOMES != "") then(
        				<AZXGCI-USER-DEMO-1>{ $OTHERS_INCOMES }</AZXGCI-USER-DEMO-1>		
        			)else(
        				<AZXGCI-USER-DEMO-1 xsi:nil="true"/>
        			)
            }
            {
            	let $NATIONALITY := fn:string($actualizacionClienteTarjetaCredito/NATIONALITY/text())
        		return
        			if($NATIONALITY != "") then(
        				<AZXGCI-USER-DEMO-2>{ $NATIONALITY }</AZXGCI-USER-DEMO-2>		
        			)else(
        				<AZXGCI-USER-DEMO-2 xsi:nil="true"/>
        			)
            }
            (:Tokenización del valor de FREQUENT_FLYEER usando el delimitador | para LM:)
            {
    			let $FREQUENT_FLYEER := data($actualizacionClienteTarjetaCredito/FREQUENT_FLYEER/text())
    			let $tokens := fn:tokenize($FREQUENT_FLYEER, "\|")
    			return (
        			if (count($tokens) > 0 and fn:string-length($tokens[1]) > 0) then (
            			<AZXGCI-USER-DEMO-3>{ $tokens[1] }</AZXGCI-USER-DEMO-3>
        			) else (
        				<AZXGCI-USER-DEMO-3/>
        			)
    			)
			}
			(: Funcionalidad para Viajero Frecuente :)
            <AZXGCI-1099C-FOREIGN-IND xsi:nil="true"/>
            <AZXGCI-CR-1-2 xsi:nil="true"/>
            <AZXGCI-CR-3-4 xsi:nil="true"/>
            <AZXGCI-1099C-W9-DATE-SENT xsi:nil="true"/>
            <AZXGCI-STMT-MSG-INDIC xsi:nil="true"/>
            (:Tokenización del valor de FREQUENT_FLYEER usando el delimitador | para AA:)
            {
    			let $FREQUENT_FLYEER := data($actualizacionClienteTarjetaCredito/FREQUENT_FLYEER/text())
    			let $tokens := fn:tokenize($FREQUENT_FLYEER, "\|")
    			return (
        			if (count($tokens) > 1 and fn:string-length($tokens[2]) > 0) then (
            			<AZXGCI-FF-NUMBER>{ $tokens[2] }</AZXGCI-FF-NUMBER>
        			) else (
            			<AZXGCI-FF-NUMBER/>
        			)
    			)
			}
			(: Funcionalidad para Viajero Frecuente :)
            {
            	let $STMT_MSG_2_INDIC := fn:string($actualizacionClienteTarjetaCredito/STMT_MSG_2_INDIC/text())
        		return
        			if($STMT_MSG_2_INDIC != "") then(
        				<AZXGCI-STMT-MSG-2-INDIC>{ $STMT_MSG_2_INDIC }</AZXGCI-STMT-MSG-2-INDIC>		
        			)else(
        				<AZXGCI-STMT-MSG-2-INDIC xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADDREES_2_INDICATOR := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDREES_2_INDICATOR/text())
        		return
        			if($WORK_ADDREES_2_INDICATOR != "") then(
        				<AZXGCI-ADDR-2-INDIC>{ $WORK_ADDREES_2_INDICATOR }</AZXGCI-ADDR-2-INDIC>		
        			)else(
        				<AZXGCI-ADDR-2-INDIC xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADDREES_3_INDICATOR := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDREES_3_INDICATOR/text())
        		return
        			if($WORK_ADDREES_3_INDICATOR != "") then(
        				<AZXGCI-ADDR-3-INDIC>{ $WORK_ADDREES_3_INDICATOR }</AZXGCI-ADDR-3-INDIC>		
        			)else(
        				<AZXGCI-ADDR-3-INDIC xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADRRESS_2_LINE_1 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS_2/WORK_ADRRESS_2_LINE_1/text())
        		return
        			if($WORK_ADRRESS_2_LINE_1 != "") then(
        				<AZXGCI-ADDR-2-LINE-1>{ $WORK_ADRRESS_2_LINE_1 }</AZXGCI-ADDR-2-LINE-1>		
        			)else(
        				<AZXGCI-ADDR-2-LINE-1 xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADRRESS_2_LINE_2 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS_2/WORK_ADRRESS_2_LINE_2/text())
        		return
        			if($WORK_ADRRESS_2_LINE_2 != "") then(
        				<AZXGCI-ADDR-2-LINE-2>{ $WORK_ADRRESS_2_LINE_2 }</AZXGCI-ADDR-2-LINE-2>		
        			)else(
        				<AZXGCI-ADDR-2-LINE-2 xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADDRESS_2_LINE_3 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS_2/WORK_ADDRESS_2_LINE_3/text())
        		return
        			if($WORK_ADDRESS_2_LINE_3 != "") then(
        				<AZXGCI-ADDR-2-LINE-3>{ $WORK_ADDRESS_2_LINE_3 }</AZXGCI-ADDR-2-LINE-3>		
        			)else(
        				<AZXGCI-ADDR-2-LINE-3 xsi:nil="true"/>
        			)
            }
            {
            	let $CITY-2 := fn:string($actualizacionClienteTarjetaCredito/CITY-2/text())
        		return
        			if($CITY-2 != "") then(
        				<AZXGCI-CITY-2>{ valorCatalogoOSBToAPP($CITY-2, 'VISION+HN', '8', $ptEquivalencias) }</AZXGCI-CITY-2>		
        			)else(
        				<AZXGCI-CITY-2 xsi:nil="true"/>
        			)
            }
            {
            	let $PSTL-CD-2 := fn:string($actualizacionClienteTarjetaCredito/PSTL-CD-2/text())
        		return
        			if($PSTL-CD-2 != "") then(
        				<AZXGCI-PSTL-CD-2>{ valorCatalogoOSBToAPP($PSTL-CD-2, 'VISION+HN', '7', $ptEquivalencias) }</AZXGCI-PSTL-CD-2>
        			)else(
        				<AZXGCI-PSTL-CD-2 xsi:nil="true"/>
        			)
            }
            {
            	let $CNTRY-CD-2 := fn:string($actualizacionClienteTarjetaCredito/CNTRY-CD-2/text())
        		return
        			if($CNTRY-CD-2 != "") then(
        				<AZXGCI-CNTRY-CD-2>{ $CNTRY-CD-2 }</AZXGCI-CNTRY-CD-2>
        			)else(
        				<AZXGCI-CNTRY-CD-2 xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADDRESS_3_LINE_1 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS_3/WORK_ADDRESS_3_LINE_1/text())
        		return
        			if($WORK_ADDRESS_3_LINE_1 != "") then(
        				<AZXGCI-ADDR-3-LINE-1>{ $WORK_ADDRESS_3_LINE_1 }</AZXGCI-ADDR-3-LINE-1>
        			)else(
        				<AZXGCI-ADDR-3-LINE-1 xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADDRESS_3_LINE_2 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS_3/WORK_ADDRESS_3_LINE_2/text())
        		return
        			if($WORK_ADDRESS_3_LINE_2 != "") then(
        				<AZXGCI-ADDR-3-LINE-2>{ $WORK_ADDRESS_3_LINE_2 }</AZXGCI-ADDR-3-LINE-2>
        			)else(
        				<AZXGCI-ADDR-3-LINE-2 xsi:nil="true"/>
        			)
            }
            {
            	let $WORK_ADDRESS_3_LINE_3 := fn:string($actualizacionClienteTarjetaCredito/WORK_ADDRESS_3/WORK_ADDRESS_3_LINE_3/text())
        		return
        			if($WORK_ADDRESS_3_LINE_3 != "") then(
        				<AZXGCI-ADDR-3-LINE-3>{ $WORK_ADDRESS_3_LINE_3 }</AZXGCI-ADDR-3-LINE-3>
        			)else(
        				<AZXGCI-ADDR-3-LINE-3 xsi:nil="true"/>
        			)
            }
            {
            	let $ALTERNATE_CITY := fn:string($actualizacionClienteTarjetaCredito/ALTERNATE_CITY/text())
        		return
        			if($ALTERNATE_CITY != "") then(
        				<AZXGCI-CITY-3>{ valorCatalogoOSBToAPP($ALTERNATE_CITY, 'VISION+HN', '8', $ptEquivalencias) }</AZXGCI-CITY-3>
        			)else(
        				<AZXGCI-CITY-3 xsi:nil="true"/>
        			)
            }
            {
            	let $PSTL-CD-3 := fn:string($actualizacionClienteTarjetaCredito/PSTL-CD-3/text())
        		return
        			if($PSTL-CD-3 != "") then(
        				<AZXGCI-PSTL-CD-3>{ valorCatalogoOSBToAPP($PSTL-CD-3, 'VISION+HN', '7', $ptEquivalencias) }</AZXGCI-PSTL-CD-3>
        			)else(
        				<AZXGCI-PSTL-CD-3 xsi:nil="true"/>
        			)
            }
            {
            	let $ALTERNATE_COUNTRY := fn:string($actualizacionClienteTarjetaCredito/ALTERNATE_COUNTRY/text())
        		return
        			if($ALTERNATE_COUNTRY != "") then(
        				<AZXGCI-CNTRY-CD-3>{ $ALTERNATE_COUNTRY }</AZXGCI-CNTRY-CD-3>
        			)else(
        				<AZXGCI-CNTRY-CD-3 xsi:nil="true"/>
        			)
            }
            <AZXGCI-USER-DATE-3 xsi:nil="true"/>
            <AZXGCI-INCOME xsi:nil="true"/>
            <AZXGCI-CUIT>0</AZXGCI-CUIT>
            <AZXGCI-OCCUP-CODE xsi:nil="true"/>
            <AZXGCI-IVA-POSITION xsi:nil="true"/>
        </ns1:CustomerUpdateL8V2Request>
};

declare variable $actualizacionClienteTarjetaCredito as element(ns0:actualizacionClienteTarjetaCredito) external;
declare variable $ptEquivalencias as element() external;

xf:customerUpdateL8V2HNIn($actualizacionClienteTarjetaCredito,
	$ptEquivalencias)