(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetalleSaldosPignorados/xsd/consultaDetalleSaldosPignorados_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleSaldosPignoradosResponse" location="../xsd/consultaDetalleSaldosPignoradosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleSaldosPignorados";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaDetalleSaldosPignorados/xq/consultaDetalleSaldosPignoradosOut/";

declare function xf:consultaDetalleSaldosPignoradosOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaDetalleSaldosPignoradosResponse) {
        
            if ($outputParameters1/ns0:ERROR_CODE="SUCCESS") then(
        <ns1:consultaDetalleSaldosPignoradosResponse>
{
                for $ACCOUNT_NAME in $outputParameters1/ns0:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $TOTAL_LOCKED_AMOUNT in $outputParameters1/ns0:TOTAL_LOCKED_AMOUNT
                return
                    <TOTAL_LOCKED_AMOUNT>{ data($TOTAL_LOCKED_AMOUNT) }</TOTAL_LOCKED_AMOUNT>
            }
            <ns1:consultaDetalleSaldosPignoradosResponseType>
                {
                	let $startDate := $outputParameters1/ns0:START_DATE/ns0:START_DATE_ITEM
                	let $liftingDate := $outputParameters1/ns0:LIFTING_DATE/ns0:START_DATE_ITEM
                	let $description := $outputParameters1/ns0:DESCRIPTION/ns0:DESCRIPTION_ITEM
                	let $amount := $outputParameters1/ns0:AMOUNT/ns0:START_DATE_ITEM
                
                    for $i in (1 to count($startDate))
                    return
                        <ns1:consultaDetalleSaldosPignoradosResponseRecordType>
                            <START_DATE>{ data($startDate[$i]) }</START_DATE>
                            <LIFTING_DATE>{ data($liftingDate[$i]) }</LIFTING_DATE>
                            <DESCRIPTION>{ data($description[$i]) }</DESCRIPTION>
                            <AMOUNT>{ data($amount[$i]) }</AMOUNT>
                        </ns1:consultaDetalleSaldosPignoradosResponseRecordType>
                }
            </ns1:consultaDetalleSaldosPignoradosResponseType>
        </ns1:consultaDetalleSaldosPignoradosResponse>
        )
        else(
        <ns1:consultaDetalleSaldosPignoradosResponse/>
        )
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaDetalleSaldosPignoradosOut($outputParameters1)