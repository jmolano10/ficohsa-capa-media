(:: pragma  parameter="$details" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:Of_cargar_ingreso_egreso_divisas" location="../../../BusinessServices/notificaDivisasDetalle/xsd/XMLSchema_1923180109.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/notificaDivisasDetalleIn/";

declare function xf:notificaDivisasDetalleIn($details as element(*),
    $user as xs:string,
    $password as xs:string,
    $entity as xs:string,
    $entrada as xs:string)
    as element(ns0:Of_cargar_ingreso_egreso_divisas) {
        <ns0:Of_cargar_ingreso_egreso_divisas>
            <ns0:ps_Usuario>{ $user }</ns0:ps_Usuario>
            <ns0:ps_Password>{ $password }</ns0:ps_Password>
            <ns0:ps_Entidad>{ $entity }</ns0:ps_Entidad>
            <ns0:ps_Entrada>{ concat( $entrada, fn-bea:serialize($details)) }</ns0:ps_Entrada>
        </ns0:Of_cargar_ingreso_egreso_divisas>
};

declare variable $details as element(*) external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $entity as xs:string external;
declare variable $entrada as xs:string external;

xf:notificaDivisasDetalleIn($details,
    $user,
    $password,
    $entity,
    $entrada)
