(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionFaltanteSobranteCajero" element="ns1:reversionFaltanteSobranteCajero" location="../../xsds/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajero.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Reversionfaltosobrcajero" location="../../xsds/ReversaTransaccion2/XMLSchema_-704599497.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionFaltanteSobranteCajeroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajeroIn/";

declare function xf:ReversionFaltanteSobranteCajeroIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversionFaltanteSobranteCajero as element(ns1:reversionFaltanteSobranteCajero),
    $tellerCat as xs:string,
    $shortageCat as xs:string,
    $overageCat as xs:string,
    $branchCode as xs:string)
    as element(ns0:Reversionfaltosobrcajero) {
        <ns0:Reversionfaltosobrcajero>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFICOHNDIFWSType>
            	{
            		for $REVERSAL_CURRENCY in $reversionFaltanteSobranteCajero/REVERSAL_CURRENCY
            		return
            			<CCY1>{ data($REVERSAL_CURRENCY) }</CCY1>
            	}
                <gACCOUNT1>
                    <mACCOUNT1>
                    	{
                    		if ( fn:string($reversionFaltanteSobranteCajero/REVERSAL_TYPE/text()) = "OVERAGE" ) then (
                    			<DEBITACCOUNT>{ concat(fn:string($reversionFaltanteSobranteCajero/REVERSAL_CURRENCY/text()),
                    									$overageCat,
                    									fn:string($reversionFaltanteSobranteCajero/TELLER_ID/text())) }</DEBITACCOUNT>	
                    			
                    	
                    		) else (
                    			<DEBITACCOUNT>{ concat(fn:string($reversionFaltanteSobranteCajero/REVERSAL_CURRENCY/text()),
                    									$tellerCat,
                    									fn:string($reversionFaltanteSobranteCajero/TELLER_ID/text())) }</DEBITACCOUNT>
                    		)
                        }
                        {
                        	if ( fn:string($reversionFaltanteSobranteCajero/REVERSAL_CURRENCY/text()) = "HNL" ) then (
                        		<DEBITAMOUNTLOCAL>{ fn:string($reversionFaltanteSobranteCajero/REVERSAL_AMOUNT/text()) }</DEBITAMOUNTLOCAL>
                        	) else (
                        		<DEBITAMOUNTFOREIGN>{ fn:string($reversionFaltanteSobranteCajero/REVERSAL_AMOUNT/text()) }</DEBITAMOUNTFOREIGN>
                        	)
                        }
                    </mACCOUNT1>
                </gACCOUNT1>
            	{
            		if ( fn:string($reversionFaltanteSobranteCajero/REVERSAL_TYPE/text()) = "OVERAGE" ) then (
            			<CREDITACCOUNT>{ concat(fn:string($reversionFaltanteSobranteCajero/REVERSAL_CURRENCY/text()),
            									$tellerCat,
            									fn:string($reversionFaltanteSobranteCajero/TELLER_ID/text())) }</CREDITACCOUNT>	
            			
            	
            		) else (
            			<CREDITACCOUNT>{ concat(fn:string($reversionFaltanteSobranteCajero/REVERSAL_CURRENCY/text()),
            									$shortageCat,
            									fn:string($reversionFaltanteSobranteCajero/TELLER_ID/text())) }</CREDITACCOUNT>
            		)
                
                }
                <LRAGENCYCODE>{ $branchCode }</LRAGENCYCODE>
            </TELLERFICOHNDIFWSType>
        </ns0:Reversionfaltosobrcajero>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversionFaltanteSobranteCajero as element(ns1:reversionFaltanteSobranteCajero) external;
declare variable $tellerCat as xs:string external;
declare variable $shortageCat as xs:string external;
declare variable $overageCat as xs:string external;
declare variable $branchCode as xs:string external;

xf:ReversionFaltanteSobranteCajeroIn($autenticacionRequestHeader,
    $reversionFaltanteSobranteCajero,
    $tellerCat,
    $shortageCat,
    $overageCat,
    $branchCode)