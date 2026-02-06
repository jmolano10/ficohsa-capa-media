xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PointsRedeemRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemGTIn/";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";

declare function xf:pointsRedeemGTIn($outputParameters1 as element(ns1:OutputParameters),
    $rewardItemParameter as xs:string,
    $pointsParameter as xs:string)
    as element(ns0:PointsRedeemRequest) {
        <ns0:PointsRedeemRequest>
        {
			let $rowBase := $outputParameters1/ns1:RowSet[1]/ns1:Row[ns1:Column/@name = 'TipoOrg' and ns1:Column/text() = 'BASE']
			return
				(        	
        				<GPXRAI-ORG>{data($rowBase/ns1:Column[upper-case(@name) = 'ORG'])}</GPXRAI-ORG>,        			       		      		
            			<GPXRAI-CARD-NBR>0</GPXRAI-CARD-NBR>,
            	     	<GPXRAI-ACCT-NBR>{data($rowBase/ns1:Column[@name = 'LMS_ACC'])}</GPXRAI-ACCT-NBR>,        			
        				<GPXRAI-SCHEME-ID>{data($rowBase/ns1:Column[@name = 'LMS_Scheme'])}</GPXRAI-SCHEME-ID>,        			
            			<GPXRAI-REWARD-ITEM>{$rewardItemParameter}</GPXRAI-REWARD-ITEM>,
            			<GPXRAI-PREPAID-CARD-NBR/>,           					
            			<GPXRAI-POINTS>{xs:decimal($pointsParameter) * 1000}</GPXRAI-POINTS>,
            			<GPXRAI-REASON-CODE>01</GPXRAI-REASON-CODE>,
            			<GPXRAI-USER-DATA>EM</GPXRAI-USER-DATA>,
            			<CuponArray>
                			<CuponElement>
                    			<GPXRAI-COUPON-DENOM>0</GPXRAI-COUPON-DENOM>
                    			<GPXRAI-COUPON-NBR>0</GPXRAI-COUPON-NBR>
                			</CuponElement>
            			</CuponArray>, 
            			<GPXRAI-NAME-1/>,
            			<GPXRAI-NAME-2/>
            	)
         }     
        </ns0:PointsRedeemRequest>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $rewardItemParameter as xs:string external;
declare variable $pointsParameter as xs:string external;

xf:pointsRedeemGTIn($outputParameters1,
    $rewardItemParameter,
    $pointsParameter)