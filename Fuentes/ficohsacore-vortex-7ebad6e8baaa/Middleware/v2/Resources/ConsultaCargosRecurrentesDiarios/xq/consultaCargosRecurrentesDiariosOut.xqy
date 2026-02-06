xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$queryCardTransactionResponse" element="ns0:QueryCardTransactionResponse" location="../../../BusinessServices/VisaNet/wsdl/WSVisaTransaction.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaCargosRecurrentesDiariosResponse" location="../xsd/consultaCargosRecurrentesDiariosTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/xq/consultaCargosRecurrentesDiariosOut/";

declare function getStatusDescripcion($valor as xs:string) as xs:string {

		if($valor = "00") then "Aplicado"
		else if ( $valor != "00" ) then "Rechazado"
		else("")
};


declare function xf:consultaCargosRecurrentesDiariosOut($queryCardTransactionResponse as element(ns0:QueryCardTransactionResponse))
    as element(ns1:consultaCargosRecurrentesDiariosResponse) {
        <ns1:consultaCargosRecurrentesDiariosResponse>
{    
                for $responseDetail in $queryCardTransactionResponse/ns0:QueryCardTransactionResult/ns0:strResponseDetail/ns0:ResponseDetail
                return
(
                    <MOVEMENT_INFORMATION>
                        {
                            for $strTransactionResponseCode in $responseDetail/ns1:strTransactionResponseCode
                            return
                                <MOVEMENT_STATUS>{ getStatusDescripcion(($strTransactionResponseCode/text())) }</MOVEMENT_STATUS>
                        }
                        {
                            for $strTransactionDate in $responseDetail/ns0:strTransactionDate
                            return
                                if ($strTransactionDate != '') then (
                                    <TRANSACTION_DATE>{ fn-bea:dateTime-from-string-with-format("M/dd/yyyy hh:mm:ss a", data($strTransactionDate)) }</TRANSACTION_DATE>
                                )  else (
                                    <TRANSACTION_DATE/>
                                )
                                
                        }
                        <TRANSACTION_AMOUNT>{ data($responseDetail/ns0:strTransactionAmount) }</TRANSACTION_AMOUNT>
                        <TRANSACTION_CURRENCY>{ data($responseDetail/ns0:strCurrencyCode) }</TRANSACTION_CURRENCY>
                    </MOVEMENT_INFORMATION>
)
            }
        </ns1:consultaCargosRecurrentesDiariosResponse>
};

declare variable $queryCardTransactionResponse as element(ns0:QueryCardTransactionResponse) external;

xf:consultaCargosRecurrentesDiariosOut($queryCardTransactionResponse)