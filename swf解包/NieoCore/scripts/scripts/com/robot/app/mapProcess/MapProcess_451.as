package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import org.taomee.utils.*;
   
   public class MapProcess_451 extends BaseMapProcess
   {
      
      public function MapProcess_451()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.conLevel["Task663MC"].visible = false;
         this.conLevel["task673MC"].visible = false;
         this.conLevel["task678MC"].visible = false;
         this.conLevel["DarkTriangleMonster"].visible = false;
         DisplayUtil.removeForParent(this.topLevel["maskMC"]);
         DisplayUtil.removeForParent(this.conLevel["mainMC"]);
         map = this;
      }
      
      override public function destroy() : void
      {
      }
   }
}

