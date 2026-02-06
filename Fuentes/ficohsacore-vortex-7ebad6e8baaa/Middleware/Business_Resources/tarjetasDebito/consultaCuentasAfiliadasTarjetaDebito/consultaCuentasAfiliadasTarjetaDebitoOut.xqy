xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse" element="ns0:ConsultaMaestraTarjetaDebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentasAfiliadasTarjetaDebitoResponse" location="consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasAfiliadasTarjetaDebitoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaCuentasAfiliadasTarjetaDebitoOut/";

declare function xf:consultaCuentasAfiliadasTarjetaDebitoOut($consultaMaestraTarjetaDebitoResponse as element(ns0:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns1:consultaCuentasAfiliadasTarjetaDebitoResponse) {
        <ns1:consultaCuentasAfiliadasTarjetaDebitoResponse>
            <ns1:consultaCuentasAfiliadasTarjetaDebitoResponseType>
                {
                	let $prymaryAccts := fn:tokenize($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType[1]/mWSFICODEBITCARDCUSTOMERDetailType[1]/PRIMARYACCT, '\|\|')
                	let $currencys := fn:tokenize($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType[1]/mWSFICODEBITCARDCUSTOMERDetailType[1]/CURRENCY1, '\|\|')
                
                    for $prymaryAcct at $i in $prymaryAccts
                    return
                    	if ($prymaryAcct != "") then (
	                    	<ns1:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType>
	                        	<ACCOUNT_NUMBER>{ $prymaryAcct }</ACCOUNT_NUMBER>
	                            <ACCOUNT_RANK>MAIN</ACCOUNT_RANK>
	                            <CURRENCY>{ $currencys[$i] }</CURRENCY>
	                        </ns1:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType>
	                    ) else (),
                                                	
                	let $scndryAccts := fn:tokenize($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType[1]/mWSFICODEBITCARDCUSTOMERDetailType[1]/SCNDRYACCT, '\|\|')
                	let $currencys := fn:tokenize($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType[1]/mWSFICODEBITCARDCUSTOMERDetailType[1]/CURRENCY1, '\|\|')
                    
                    for $scndryAcct at $j in $scndryAccts
                    return
                    	if ($scndryAcct != "") then (
	                    	for $cta in fn:tokenize($scndryAcct, '!!')
	                    	return
	                    	if ($cta != "") then (
		                    	<ns1:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType>
		                        	<ACCOUNT_NUMBER>{ $cta }</ACCOUNT_NUMBER>
		                            <ACCOUNT_RANK>SECONDARY</ACCOUNT_RANK>
		                            <CURRENCY>{ $currencys[$j] }</CURRENCY>
		                        </ns1:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType>
		                    ) else ()
                     	) else ()                  		
                }
            </ns1:consultaCuentasAfiliadasTarjetaDebitoResponseType>
        </ns1:consultaCuentasAfiliadasTarjetaDebitoResponse>
};

declare variable $consultaMaestraTarjetaDebitoResponse as element(ns0:ConsultaMaestraTarjetaDebitoResponse) external;

xf:consultaCuentasAfiliadasTarjetaDebitoOut($consultaMaestraTarjetaDebitoResponse)