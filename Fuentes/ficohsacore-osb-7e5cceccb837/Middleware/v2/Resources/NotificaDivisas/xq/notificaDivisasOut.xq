(:: pragma  parameter="$details" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:notificaDivisasResponse" location="../xsd/notificaDivisasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaDivisasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/notificaDivisasOut/";

declare function xf:notificaDivisasOut($details as element(*))
    as element(ns0:notificaDivisasResponse) {
        <ns0:notificaDivisasResponse>
            <DATE>{ data($details/fecha) }</DATE>
            <ENTITY>{ data($details/entidad) }</ENTITY>
            <CORRELATIVE>{ data($details/correlativo) }</CORRELATIVE>
        </ns0:notificaDivisasResponse>
};

declare variable $details as element(*) external;

xf:notificaDivisasOut($details)
