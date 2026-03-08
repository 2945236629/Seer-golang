package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_1017 extends BaseMapProcess
   {
      
      private var btnArray:Array = new Array();
      
      public function MapProcess_1017()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.addEvents();
      }
      
      private function addEvents() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = conLevel["openBtn_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc2_.buttonMode = true;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onOpen);
               this.btnArray.push(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function onOpen(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.substr(_loc2_.indexOf("_") + 1,1));
         switch(_loc3_)
         {
            case 0:
               StatManager.sendStat2014("实验室改造","升级基地内点击商店",StatManager.USER_CHARACTER);
               ModuleManager.showModule(ClientConfig.getAppModule("SupermarketPanel"),"正在打开...","升级");
               break;
            case 1:
               StatManager.sendStat2014("实验室改造","升级基地内点击经验值战场",StatManager.USER_CHARACTER);
               ModuleManager.showModule(ClientConfig.getAppModule("TrainingCollectionPanel"));
               break;
            case 2:
               StatManager.sendStat2014("实验室改造","升级基地内点击经验兑换",StatManager.USER_CHARACTER);
               ModuleManager.showModule(ClientConfig.getAppModule("ExshiwExpPanel"));
               break;
            case 3:
               StatManager.sendStat2014("实验室改造","升级基地内点击精灵一键满级",StatManager.USER_CHARACTER);
               ModuleManager.showModule(ClientConfig.getAppModule("PetCulturePanel"));
         }
      }
      
      override public function destroy() : void
      {
         this.removeEvents();
      }
      
      private function removeEvents() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.btnArray.length)
         {
            if(this.btnArray[_loc1_] != null)
            {
               this.btnArray[_loc1_].removeEventListener(MouseEvent.CLICK,this.onOpen);
               this.btnArray[_loc1_] = null;
            }
            _loc1_++;
         }
      }
   }
}

