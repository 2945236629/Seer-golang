package com.robot.app.mapProcess
{
   import com.robot.app.ogre.*;
   import com.robot.app.task.petstory.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.*;
   import com.robot.core.info.pet.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.utils.*;
   
   public class MapProcess_669 extends BaseMapProcess
   {
      
      public function MapProcess_669()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         this.initMC();
         Task753.initTaskForMap669(this);
         TasksManager.getProStatusList(753,function(param1:Array):void
         {
            var a:Array = param1;
            if(Boolean(a[0]) && Boolean(a[1]) && Boolean(a[2]) && !a[3])
            {
               return;
            }
            Task746.initTaskFor669(map);
            TasksManager.getProStatusList(746,function(param1:Array):void
            {
               if(Boolean(param1[3]) && !param1[4])
               {
                  return;
               }
               getPetInfo(884);
               Task_715.getInstance().init(map);
            });
         });
      }
      
      private function getPetInfo(param1:int) : void
      {
         SocketConnection.addCmdListener(CommandID.PET_BARGE_LIST,this.onPetBarge);
         SocketConnection.send(CommandID.PET_BARGE_LIST,param1,param1);
      }
      
      private function onPetBarge(param1:SocketEvent) : void
      {
         Task705.initTaskForMap669();
         SocketConnection.removeCmdListener(CommandID.PET_BARGE_LIST,this.onPetBarge);
         var _loc2_:PetBargeListInfo = param1.data as PetBargeListInfo;
         var _loc3_:Array = _loc2_.isCatchedList;
         OgreController.isShow = false;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_][0] == 884 && _loc3_[_loc4_][1] == 1)
            {
               OgreController.isShow = true;
               DisplayUtil.removeForParent(conLevel["task_706_0"]);
               break;
            }
            _loc4_++;
         }
         if(TasksManager.getTaskStatus(705) == TasksManager.ALR_ACCEPT)
         {
            return;
         }
         Task706.initTaskForMap669(this);
      }
      
      private function initMC() : void
      {
         conLevel["task705_1"].visible = false;
         conLevel["btn0"].visible = false;
         conLevel["btn1"].visible = false;
         conLevel["btn2"].visible = false;
         conLevel["btn3"].visible = false;
         conLevel["pet0"].visible = false;
         conLevel["pet1"].visible = false;
         conLevel["pet2"].visible = false;
         conLevel["pirate"].visible = false;
         conLevel["guide_mc0"].visible = false;
         conLevel["guide_mc1"].visible = false;
         conLevel["guide_mc2"].visible = false;
         conLevel["guidemc746"].visible = false;
         conLevel["task715MC"].visible = false;
         depthLevel["dragon"].visible = false;
         conLevel["task_706_0"].visible = false;
      }
      
      override public function destroy() : void
      {
         Task705.destroyForMap669();
         Task706.destroy();
         OgreController.isShow = true;
         Task_715.getInstance().destroy();
         Task746.destroy();
         Task753.destroy();
      }
   }
}

