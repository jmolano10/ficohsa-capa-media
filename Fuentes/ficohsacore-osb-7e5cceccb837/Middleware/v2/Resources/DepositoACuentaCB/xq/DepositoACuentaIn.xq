(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoACuenta1" element="ns3:depositoACuenta" location="../xsd/depositoACuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/MDW/consultarCorresponsalB/xsd/consultarCorresponsalB_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/depositoX/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 declare function getTxnReference($reference as xs:string)  as xs:string {      
		 let $refList := fn:tokenize($reference,"-")
		 let $Text:= fn:substring-after($reference,"-")
		 let $Count:=fn:count($refList)
		 let $CountCadenaDeudor:=string-length($Text)-string-length($refList[$Count])
		 let $Text2:=fn:substring($Text,1,fn:number($CountCadenaDeudor)-1)
		 let $CodigoDeudor:=fn:replace($Text2,"-","..")
		 let $NombreDeudor:=fn:replace(fn:substring-after($Text,$Text2),"-","")
		 let $NumeroTransaccion:=fn:concat(fn:string($refList[1]),"-",$CodigoDeudor,"-",$NombreDeudor)
		 return
		 if ($refList[1] ="DRF") then 
		     $NumeroTransaccion
		 else
		     $reference		 
 };
 
 (: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:depositoX($requestHeader1 as element(ns0:RequestHeader),
    $depositoACuenta1 as element(ns3:depositoACuenta),
    $outputParameters1 as element(ns2:OutputParameters))
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                {
                    for $PV_TIPO_TRANSACCION in $outputParameters1/ns2:PV_TIPO_TRANSACCION
                    return
                        <TRANSACTIONTYPE>{ data($PV_TIPO_TRANSACCION) }</TRANSACTIONTYPE>
                }
                {
                    for $PV_CUENTA_DEBITO in $outputParameters1/ns2:PV_CUENTA_DEBITO
                    return
                        <DEBITACCTNO>{ data($PV_CUENTA_DEBITO) }</DEBITACCTNO>
                }
                <DEBITCURRENCY>{ data($depositoACuenta1/CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($depositoACuenta1/DEPOSIT_ITEMS/DEPOSIT_ITEM[1]/AMOUNT) }</DEBITAMOUNT>
                <CREDITACCTNO>{ data($depositoACuenta1/ACCOUNT_NUMBER) }</CREDITACCTNO>
                <gPAYMENTDETAILS>
                {
                	for $nombre in splitString(data($depositoACuenta1/INSTRUCTING_PARTY/PAYER_ID),34)
                		return
                			if(fn:string($nombre) != "") then (
                				<PAYMENTDETAILS>{$nombre}</PAYMENTDETAILS>
                			) else ()
                }
                {
                	for $nombre in tokenize($depositoACuenta1/INSTRUCTING_PARTY/PAYER_NAME, '\|\|')
                		return
                		for $nombreAux in splitString(data($nombre),34)
                		return
                			if(fn:string($nombreAux) != "" and not( fn:contains($nombreAux,'[') and 
                														 fn:contains($nombreAux,']') )) then (					 
                				<PAYMENTDETAILS>{fn:replace(getTxnReference(fn:string($nombreAux)),"/","")}</PAYMENTDETAILS>
                			) else ()        
                }
                </gPAYMENTDETAILS>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $depositoACuenta1 as element(ns3:depositoACuenta) external;
declare variable $outputParameters1 as element(ns2:OutputParameters) external;

xf:depositoX($requestHeader1,
    $depositoACuenta1,
    $outputParameters1)