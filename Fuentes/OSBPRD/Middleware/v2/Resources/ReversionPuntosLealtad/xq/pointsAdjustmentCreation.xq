(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conTransaccionRedencion/xsd/conTransaccionRedencion_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PointsAdjustmentCreationRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionRedencion";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionPuntosLealtad/xq/pointsAdjustmentCreation/";

declare function xf:pointsAdjustmentCreation($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:PointsAdjustmentCreationRequest) {
        <ns1:PointsAdjustmentCreationRequest>
        {
          for $row in $outputParameters1/ns0:RowSet/ns0:Row
          return
          if ($row/ns0:Column[upper-case(@name) = 'TIPOORG']/text() = "BASE")then (
          
           <GPXPAI-ORG>{ data($row/ns0:Column[upper-case(@name) = 'ORG']/text()) }</GPXPAI-ORG>,
           <GPXPAI-CARD-NBR/>,
           <GPXPAI-ACCT-NBR>{ string($row/ns0:Column[upper-case(@name) = 'LMSCUENTA']/text()) }</GPXPAI-ACCT-NBR>,
           <GPXPAI-SCHEME-ID>{ string($row/ns0:Column[upper-case(@name) = 'LMSESQUEMA']/text()) }</GPXPAI-SCHEME-ID>,
           <GPXPAI-TXN-CODE>{ string($row/ns0:Column[upper-case(@name) = 'CODIGOTRANSACCION']/text()) }</GPXPAI-TXN-CODE>,
           <GPXPAI-TRAN-AMT>{ xs:integer(fn:ceiling(xs:double($row/ns0:Column[upper-case(@name) = 'MONTO']))) }</GPXPAI-TRAN-AMT>,
           <GPXPAI-ACTUAL-VALUE>00000000000000000</GPXPAI-ACTUAL-VALUE>,
           <GPXPAI-DESC>{ string($row/ns0:Column[upper-case(@name) = 'DESCRIPCION']/text()) }</GPXPAI-DESC>,
           <GPXPAI-GROUP-CODE>{ string($row/ns0:Column[upper-case(@name) = 'GRUPOPROMOCIONAL']/text()) }</GPXPAI-GROUP-CODE>,
           <GPXPAI-TABLE-TYPE>{ string($row/ns0:Column[upper-case(@name) = 'TIPOPLAN']/text()) }</GPXPAI-TABLE-TYPE>,
           <GPXPAI-TABLE-PRI>{ string($row/ns0:Column[upper-case(@name) = 'PRIORIDADPLAN']/text()) }</GPXPAI-TABLE-PRI>,
           <GPXPAI-REF-NBR>{ string($row/ns0:Column[upper-case(@name) = 'IDENTIFICADORTRANSACCION']/text()) }</GPXPAI-REF-NBR>,
           <GPXPAI-REASON-CODE>0</GPXPAI-REASON-CODE>,
           <GPXPAI-STORE-NBR>000000000</GPXPAI-STORE-NBR>,
           <GPXPAI-RESV-CODE-1>00</GPXPAI-RESV-CODE-1>,
           <GPXPAI-RESV-CODE-2>00</GPXPAI-RESV-CODE-2>,
           <GPXPAI-RESV-CODE-3>00</GPXPAI-RESV-CODE-3>,
           <GPXPAI-RESV-CODE-4>00</GPXPAI-RESV-CODE-4>,
           <GPXPAI-RESV-CODE-5>00</GPXPAI-RESV-CODE-5>,
           <GPXPAI-RESV-DATE-1>0000000</GPXPAI-RESV-DATE-1>,
           <GPXPAI-RESV-DATE-2>0000000</GPXPAI-RESV-DATE-2>,
           <GPXPAI-RESV-DATE-3>0000000</GPXPAI-RESV-DATE-3>,
           <GPXPAI-RESV-DATE-4>0000000</GPXPAI-RESV-DATE-4>,
           <GPXPAI-RESV-DATE-5>0000000</GPXPAI-RESV-DATE-5>,
           <GPXPAI-RESV-AMT-1>00000000000000000</GPXPAI-RESV-AMT-1>,
           <GPXPAI-RESV-AMT-2>00000000000000000</GPXPAI-RESV-AMT-2>,
           <GPXPAI-RESV-AMT-3>00000000000000000</GPXPAI-RESV-AMT-3>,
           <GPXPAI-RESV-AMT-4>00000000000000000</GPXPAI-RESV-AMT-4>,
           <GPXPAI-RESV-AMT-5>00000000000000000</GPXPAI-RESV-AMT-5>
          )else ()
          
          }    
        </ns1:PointsAdjustmentCreationRequest>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:pointsAdjustmentCreation($outputParameters1)