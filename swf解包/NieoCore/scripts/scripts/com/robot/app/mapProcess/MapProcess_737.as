package com.robot.app.mapProcess
{
   import com.robot.core.behavior.ChangeClothBehavior;
   import com.robot.core.info.clothInfo.PeopleItemInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_737 extends BaseMapProcess
   {
      
      public function MapProcess_737()
      {
         super();
      }
      
      override protected function init() : void
      {
         var cloths:Array = null;
         cloths = [new PeopleItemInfo(1300062)];
         if(TasksManager.getTaskStatus(1105) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(1105,function():void
            {
               TasksManager.complete(1105,0,function():void
               {
                  MainManager.actorModel.execBehavior(new ChangeClothBehavior(cloths));
                  MainManager.actorInfo.clothes = cloths;
               });
            });
         }
         else if(TasksManager.getTaskStatus(1105) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.complete(1105,0,function():void
            {
               MainManager.actorModel.execBehavior(new ChangeClothBehavior(cloths));
               MainManager.actorInfo.clothes = cloths;
            });
         }
         else
         {
            MainManager.actorModel.execBehavior(new ChangeClothBehavior(cloths));
            MainManager.actorInfo.clothes = cloths;
         }
      }
      
      override public function destroy() : void
      {
      }
   }
}

