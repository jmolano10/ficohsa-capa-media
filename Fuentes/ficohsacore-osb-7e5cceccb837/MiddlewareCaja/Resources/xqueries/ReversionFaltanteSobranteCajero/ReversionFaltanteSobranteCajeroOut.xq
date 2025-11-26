(:: pragma bea:global-element-parameter parameter="$reversionfaltosobrcajeroResponse" element="ns1:ReversionfaltosobrcajeroResponse" location="../../xsds/ReversaTransaccion2/XMLSchema_-704599497.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversionFaltanteSobranteCajeroResponse" location="../../xsds/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajero.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionFaltanteSobranteCajeroTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajeroOut/";

declare function xf:ReversionFaltanteSobranteCajeroOut($reversionfaltosobrcajeroResponse as element(ns1:ReversionfaltosobrcajeroResponse),
    $branchName as xs:string)
    as element(ns0:reversionFaltanteSobranteCajeroResponse) {
        <ns0:reversionFaltanteSobranteCajeroResponse>
            {
                let $result :=
                    for $INPUTTER in $reversionfaltosobrcajeroResponse/TELLERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $reversionfaltosobrcajeroResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
        </ns0:reversionFaltanteSobranteCajeroResponse>
};

declare variable $reversionfaltosobrcajeroResponse as element(ns1:ReversionfaltosobrcajeroResponse) external;
declare variable $branchName as xs:string external;

xf:ReversionFaltanteSobranteCajeroOut($reversionfaltosobrcajeroResponse,
    $branchName)