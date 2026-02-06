xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadechequesenreservaResponse1" element="ns0:ConsultadechequesenreservaResponse" location="../Resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequesReservaResponse" location="consultaChequesReservaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/consultaChequesReserva/consultaChequeReservaOut/";

(: Se encarga de Calcular los dias de diferencia entre 2 cadenas de caracteres que representan fechas en formato "YYYYMMDD" :)
declare function local:days-between-dates($primeraFecha as xs:string, $segundaFecha as xs:string) as xs:string
{
	if ( fn-bea:trim($primeraFecha) = "" or fn-bea:trim($segundaFecha) = "") then (
		""
	)
	else (
		xs:string(
			days-from-duration(
				xs:date(concat(substring($primeraFecha, 1, 4), "-", substring($primeraFecha, 5, 2), "-", substring($primeraFecha, 7))) - 
				xs:date(concat(substring($segundaFecha, 1, 4), "-", substring($segundaFecha, 5, 2), "-", substring($segundaFecha, 7)))
			)
		)
		
	)
};

(: Se encarga de Calcular los dias de diferencia entre 1 cadena de caracteres que representa una fecha en formato "YYYYMMDD" y la fecha actual:)
declare function local:days-between-custom-date-and-current-date($primeraFecha as xs:string) as xs:string
{
	if ( fn-bea:trim($primeraFecha) = "") then (
		""
	)
	else (
		xs:string(
			days-from-duration(
				xs:date(concat(substring($primeraFecha, 1, 4), "-", substring($primeraFecha, 5, 2), "-", substring($primeraFecha, 7))) - 
				current-date()
			)
		)
		
	)
};

(: Se encarga de convertir un date a string en formato "YYYYMMDD" :)
declare function date-to-string($fecha as xs:date) as xs:string
{
	concat(substring(xs:string($fecha), 1, 4), substring(xs:string($fecha), 6, 2), substring(xs:string($fecha), 9, 2))
};

declare function xf:consultaChequeReservaOut($consultadechequesenreservaResponse1 as element(ns0:ConsultadechequesenreservaResponse))
    as element(ns1:consultaChequesReservaResponse) {
        <ns1:consultaChequesReservaResponse>
            {
            	if ( $consultadechequesenreservaResponse1/Status/successIndicator/text() = "Success" and empty($consultadechequesenreservaResponse1/WSCHQCOLLDETAILSType[1]/ZERORECORDS/text())) then (
		            <ACCOUNT_NAME>{ data($consultadechequesenreservaResponse1/WSCHQCOLLDETAILSType[1]/ACCOUNTNAME) }</ACCOUNT_NAME>,
		            <TOTAL_CLEARING_AMOUNT>{ data($consultadechequesenreservaResponse1/WSCHQCOLLDETAILSType[1]/TOTALCHQSAMOUNT) }</TOTAL_CLEARING_AMOUNT>,
		            <consultaChequesReservaResponseType>
		                {
		                    for $mWSCHQCOLLDETAILSDetailType in $consultadechequesenreservaResponse1/WSCHQCOLLDETAILSType[1]/gWSCHQCOLLDETAILSDetailType/mWSCHQCOLLDETAILSDetailType
		                    return
		                        <consultaChequesReservaResponseRecordType>
		                            <BANK_NAME>{ data($mWSCHQCOLLDETAILSDetailType/BANKNAME) }</BANK_NAME>
		                            <CHEQUE_NUMBER>{ data($mWSCHQCOLLDETAILSDetailType/CHEQUENO) }</CHEQUE_NUMBER>
		                            <AMOUNT>{ data($mWSCHQCOLLDETAILSDetailType/CHEQUEAMOUNT) }</AMOUNT>
		                            <CHEQUE_STATUS>{ data($mWSCHQCOLLDETAILSDetailType/CHQSTATUS) }</CHEQUE_STATUS>
		                            <RELEASE_DATE>{ data($mWSCHQCOLLDETAILSDetailType/EXPDATE) }</RELEASE_DATE>
		                            <CLEARING_DATE>{ data($mWSCHQCOLLDETAILSDetailType/VALDATE) }</CLEARING_DATE>
		                            <CLEARING_DAYS>{ 
		                            					if (data($mWSCHQCOLLDETAILSDetailType/VALDATE) < data($mWSCHQCOLLDETAILSDetailType/EXPDATE) ) then (
		                            						local:days-between-dates( data($mWSCHQCOLLDETAILSDetailType/EXPDATE), data($mWSCHQCOLLDETAILSDetailType/VALDATE) )
		                            					) 
		                            					else (
		                            						0
		                            					) 
		                            				}
		                            </CLEARING_DAYS>
		                            <CLEARING_REMAINING_DAYS>{ 
		                            							if ( date-to-string(current-date()) < data($mWSCHQCOLLDETAILSDetailType/EXPDATE) ) then (
		                            								local:days-between-custom-date-and-current-date( data($mWSCHQCOLLDETAILSDetailType/EXPDATE) )
		                            							)
		                            							else (
		                            								0
		                            							)
		                            						  }
		                        </CLEARING_REMAINING_DAYS>
		                        </consultaChequesReservaResponseRecordType>
		                }
		            </consultaChequesReservaResponseType>
				) else ()
			}
        </ns1:consultaChequesReservaResponse>
};

declare variable $consultadechequesenreservaResponse1 as element(ns0:ConsultadechequesenreservaResponse) external;

xf:consultaChequeReservaOut($consultadechequesenreservaResponse1)