package com.robot.app.mapProcess
{
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.UserManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.BasePeoleModel;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_1553 extends BaseMapProcess
   {
      
      public function MapProcess_1553()
      {
         super();
      }
      
      override protected function init() : void
      {
         EventManager.addEventListener(RobotEvent.CREATED_MAP_USER,this.onUserHandler);
         super.init();
      }
      
      private function onUserHandler(param1:RobotEvent) : void
      {
         this.configModel(0.6,1);
      }
      
      private function configModel(param1:Number, param2:Number) : void
      {
         var _loc3_:BasePeoleModel = null;
         MainManager.actorModel.scaleX = MainManager.actorModel.scaleY = param1;
         if(MainManager.actorModel.pet)
         {
            MainManager.actorModel.pet.scaleX = MainManager.actorModel.pet.scaleY = param2;
         }
         for each(_loc3_ in UserManager.getUserModelList())
         {
            if(_loc3_)
            {
               _loc3_.scaleX = _loc3_.scaleY = param1;
               if(_loc3_.pet)
               {
                  _loc3_.pet.scaleX = _loc3_.pet.scaleY = param2;
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:BasePeoleModel = null;
         MainManager.actorModel.scaleX = MainManager.actorModel.scaleY = 1;
         if(MainManager.actorModel.pet)
         {
            MainManager.actorModel.pet.scaleX = MainManager.actorModel.pet.scaleY = 1;
         }
         for each(_loc1_ in UserManager.getUserModelList())
         {
            if(_loc1_)
            {
               _loc1_.scaleX = _loc1_.scaleY = 1;
               if(_loc1_.pet)
               {
                  _loc1_.pet.scaleX = _loc1_.pet.scaleY = 1;
               }
            }
         }
         EventManager.removeEventListener(RobotEvent.CREATED_MAP_USER,this.onUserHandler);
         super.destroy();
      }
   }
}

