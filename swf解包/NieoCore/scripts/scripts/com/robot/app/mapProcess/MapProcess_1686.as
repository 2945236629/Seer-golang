package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_1686 extends BaseMapProcess
   {
      
      public function MapProcess_1686()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.conClickHandle);
      }
      
      private function conClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "btn0":
               ModuleManager.showAppModule("MeteoriteIdentificationEnterPanel");
               break;
            case "btn1":
               ModuleManager.showAppModule("YingHeBuJiMainPanel");
               break;
            case "kf":
               this.showDialog();
         }
      }
      
      private function showDialog() : void
      {
         NpcDialog.show(5793,["你好，我是科飞。星空浩瀚无比，探索永无止境！"],["前往【星间探秘 赛尔寻迹】活动","暂时离开"],[function():void
         {
            ModuleManager.showAppModule("TianWenGuanEnterPanel");
         },null],false,null,true);
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.conClickHandle);
         super.destroy();
      }
   }
}

