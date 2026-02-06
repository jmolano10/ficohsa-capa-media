xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conTransaccionRedencion/xsd/conTransaccionRedencion_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversionPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionRedencion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/reversionPuntosLealtadGTOut/";

declare function xf:reversionPuntosLealtadGTOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:reversionPuntosLealtadResponse) {
        <ns0:reversionPuntosLealtadResponse>
        {
         for $row in $outputParameters1/ns1:RowSet/ns1:Row
          return
          if ($row/ns1:Column[upper-case(@name) = 'TIPOORG']/text() = "BASE")then (
          
            <LEGAL_ID>{ data($row/ns1:Column[@name = 'legal_id']/text()) }</LEGAL_ID>,
            <CUSTOMER_NAME>{ data($row/ns1:Column[@name = 'nombre_cliente']/text()) }</CUSTOMER_NAME>,
            <CREDIT_RESULT>
                <REDEMPTION_ID>{ data($row/ns1:Column[@name = 'IdentificadorTransaccion']/text()) }</REDEMPTION_ID>
                <TOTAL_POINTS_CREDITED>{ xs:integer(fn:ceiling(xs:double($row/ns1:Column[@name = 'Monto']))) }</TOTAL_POINTS_CREDITED>
            </CREDIT_RESULT>
            )else ()
         }
        </ns0:reversionPuntosLealtadResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:reversionPuntosLealtadGTOut($outputParameters1)